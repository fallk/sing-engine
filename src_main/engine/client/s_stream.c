/*
s_stream.c - sound streaming
Copyright (C) 2009 Uncle Mike

This program is free software: you can redistribute it and/or modify
it under the terms of the GNU General Public License as published by
the Free Software Foundation, either version 3 of the License, or
(at your option) any later version.

This program is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
GNU General Public License for more details.
*/

#include "common.h"
#include "sound.h"
#include "client.h"

portable_samplepair_t	s_rawsamples[MAX_RAW_SAMPLES];
static bg_track_t		s_bgTrack;
int			s_rawend;

void S_CheckLerpingState( void )
{
	wavdata_t	*info;

	s_listener.lerping = false;
	if( !s_bgTrack.stream ) return;
	info = FS_StreamInfo( s_bgTrack.stream );

	if( info && ((float)info->rate / SOUND_DMA_SPEED ) >= 1.0f )
		s_listener.lerping = s_lerping->integer;
}

/*
=================
S_StartBackgroundTrack
=================
*/
void S_StartBackgroundTrack( const char *introTrack, const char *mainTrack )
{
	S_StopBackgroundTrack();

	if( !dma.initialized ) return;
	if(( !introTrack || !*introTrack ) && ( !mainTrack || !*mainTrack ))
		return;

	if( !introTrack ) introTrack = mainTrack;
	if( !*introTrack ) return;

	if( !mainTrack || !*mainTrack ) s_bgTrack.loopName[0] = '\0';
	else Q_strncpy( s_bgTrack.loopName, mainTrack, sizeof( s_bgTrack.loopName ));

	// open stream
	s_bgTrack.stream = FS_OpenStream( va( "media/%s", introTrack ));
	s_bgTrack.source = cls.key_dest;

	S_CheckLerpingState();
}

void S_StopBackgroundTrack( void )
{
	s_listener.stream_paused = false;

	if( !dma.initialized ) return;
	if( !s_bgTrack.stream ) return;

	FS_FreeStream( s_bgTrack.stream );
	Q_memset( &s_bgTrack, 0, sizeof( bg_track_t ));
	s_listener.lerping = false;
	s_rawend = 0;
}

void S_StreamSetPause( int pause )
{
	s_listener.stream_paused = pause;
}

/*
=================
S_StreamBackgroundTrack
=================
*/
void S_StreamBackgroundTrack( void )
{
	int	bufferSamples;
	int	fileSamples;
	byte	raw[MAX_RAW_SAMPLES];
	int	r, fileBytes;

	if( !dma.initialized ) return;
	if( !s_bgTrack.stream ) return;
	if( s_listener.streaming ) return;	// we are playing movie or somewhat

	// don't bother playing anything if musicvolume is 0
	if( !s_musicvolume->value || s_listener.paused || s_listener.stream_paused )
		return;

	if( !cl.background )
	{
		// pause music by source type
		if( s_bgTrack.source == key_game && cls.key_dest == key_menu ) return;
		if( s_bgTrack.source == key_menu && cls.key_dest != key_menu ) return;
	}
	else if( cls.key_dest == key_console )
		return;

	// see how many samples should be copied into the raw buffer
	if( s_rawend < soundtime )
		s_rawend = soundtime;

	while( s_rawend < soundtime + MAX_RAW_SAMPLES )
	{
		wavdata_t	*info = FS_StreamInfo( s_bgTrack.stream );

		bufferSamples = MAX_RAW_SAMPLES - (s_rawend - soundtime);

		// decide how much data needs to be read from the file
		fileSamples = bufferSamples * ((float)info->rate / SOUND_DMA_SPEED );
		if( fileSamples <= 1 ) return; // no more samples need

		// our max buffer size
		fileBytes = fileSamples * ( info->width * info->channels );

		if( fileBytes > sizeof( raw ))
		{
			fileBytes = sizeof( raw );
			fileSamples = fileBytes / ( info->width * info->channels );
		}

		// read
		r = FS_ReadStream( s_bgTrack.stream, fileBytes, raw );

		if( r < fileBytes )
		{
			fileBytes = r;
			fileSamples = r / ( info->width * info->channels );
		}

		if( r > 0 )
		{
			// add to raw buffer
			S_StreamRawSamples( fileSamples, info->rate, info->width, info->channels, raw );
		}
		else
		{
			// loop
			if( s_bgTrack.loopName[0] )
			{
				FS_FreeStream( s_bgTrack.stream );
				s_bgTrack.stream = FS_OpenStream( va( "media/%s", s_bgTrack.loopName ));

				if( !s_bgTrack.stream ) return;
				S_CheckLerpingState();
			}
			else
			{
				S_StopBackgroundTrack();
				return;
			}
		}

	}
}

/*
=================
S_StartStreaming
=================
*/
void S_StartStreaming( void )
{
	if( !dma.initialized ) return;
	// begin streaming movie soundtrack
	s_listener.streaming = true;
	s_listener.lerping = false;
}

/*
=================
S_StopStreaming
=================
*/
void S_StopStreaming( void )
{
	if( !dma.initialized ) return;
	s_listener.streaming = false;
	s_listener.lerping = false;
	s_rawend = 0;
}

/*
=================
S_StreamSoundTrack
=================
*/
void S_StreamSoundTrack( void )
{
	int	bufferSamples;
	int	fileSamples;
	byte	raw[MAX_RAW_SAMPLES];
	int	r, fileBytes;

	if( !dma.initialized ) return;
	if( !s_listener.streaming || s_listener.paused ) return;

	// see how many samples should be copied into the raw buffer
	if( s_rawend < soundtime )
		s_rawend = soundtime;

	while( s_rawend < soundtime + MAX_RAW_SAMPLES )
	{
		wavdata_t	*info = SCR_GetMovieInfo();

		bufferSamples = MAX_RAW_SAMPLES - (s_rawend - soundtime);

		// decide how much data needs to be read from the file
		fileSamples = bufferSamples * ((float)info->rate / SOUND_DMA_SPEED );
		if( fileSamples <= 1 ) return; // no more samples need

		// our max buffer size
		fileBytes = fileSamples * ( info->width * info->channels );

		if( fileBytes > sizeof( raw ))
		{
			fileBytes = sizeof( raw );
			fileSamples = fileBytes / ( info->width * info->channels );
		}

		// read audio stream
		r = SCR_GetAudioChunk( raw, fileBytes );

		if( r < fileBytes )
		{
			fileBytes = r;
			fileSamples = r / ( info->width * info->channels );
		}

		if( r > 0 )
		{
			// add to raw buffer
			S_StreamRawSamples( fileSamples, info->rate, info->width, info->channels, raw );
		}
		else break; // no more samples for this frame
	}
}

/*
============
S_StreamRawSamples

Cinematic streaming and voice over network
============
*/
void S_StreamRawSamples( int samples, int rate, int width, int channels, const byte *data )
{
	int	i, a, b, src, dst;
	int	fracstep, samplefrac;
	int	incount, outcount;

	src = 0;
	samplefrac = 0;
	fracstep = (((double)rate) / (double)SOUND_DMA_SPEED) * 256.0;
	outcount = (double)samples * (double)SOUND_DMA_SPEED / (double)rate;
	incount = samples * channels;

#define TAKE_SAMPLE( s )	(sizeof(*in) == 1 ? (a = (in[src+(s)]-128)<<8,\
			b = (src < incount - channels) ? (in[src+channels+(s)]-128)<<8 : 128) : \
			(a = in[src+(s)],\
			b = (src < incount - channels) ? (in[src+channels+(s)]) : 0))

			// NOTE: disable lerping for cinematic sountracks
#define LERP_SAMPLE		s_listener.lerping ? (((((b - a) * (samplefrac & 255)) >> 8) + a)) : a

#define RESAMPLE_RAW \
	if( channels == 2 ) { \
		for( i = 0; i < outcount; i++, samplefrac += fracstep, src = (samplefrac >> 8) << 1 ) { \
			dst = s_rawend++ & (MAX_RAW_SAMPLES - 1); \
			TAKE_SAMPLE(0); \
			s_rawsamples[dst].left = LERP_SAMPLE; \
			TAKE_SAMPLE(1); \
			s_rawsamples[dst].right = LERP_SAMPLE; \
		} \
	} else { \
		for( i = 0; i < outcount; i++, samplefrac += fracstep, src = (samplefrac >> 8) << 0 ) { \
			dst = s_rawend++ & (MAX_RAW_SAMPLES - 1); \
			TAKE_SAMPLE(0); \
			s_rawsamples[dst].left = LERP_SAMPLE; \
			s_rawsamples[dst].right = s_rawsamples[dst].left; \
		} \
	}
		
	if( s_rawend < paintedtime )
		s_rawend = paintedtime;

	if( width == 2 )
	{
		short *in = (short *)data;
		RESAMPLE_RAW
	}
	else
	{
		byte *in = (unsigned char *)data;
		RESAMPLE_RAW
	}
}