
DOCROOT=/var/www/usp
SRC="http://windows.clavain.co.uk:3000/S19.2E-1-1089-12020.ts"
PUBPOINT="http://demo.unified-streaming.com/rtl2.isml/Streams(rtl2)?archive_segment_length=60&dvr_window_length=30&archiving=0"

MP4SPLIT=mp4split --license-key=/mnt/usp_test/development-license.key

FFMPEG_OPTIONS=-f ism -async 128 -vsync 1 -threads 2
AUDIO_OPTIONS=-acodec libfaac -ac 2 -ab 64k
VIDEO_OPTIONS=-vcodec libx264 -vpre veryfast -vpre baseline -g 100 -keyint_min 50 -sc_threshold 0

$(DOCROOT)/rtl2.isml/rtl2.ism:
	-rm $(DOCROOT)/rtl2.isml/*
	-mkdir $(DOCROOT)/rtl2.isml
	ffmpeg -i $(SRC) $(FFMPEG_OPTIONS) $(AUDIO_OPTIONS) $(VIDEO_OPTIONS) \
		 -b 400k -s 360x288 $(PUBPOINT) \
		 -b 200k -s 180x144 -newvideo

rtl2: $(DOCROOT)/rtl2.isml/rtl2.ism

TIMESTAMP:=$(shell curl http://time.akamai.com/?iso)

MP4SPLIT_OPTIONS=
MP4SPLIT_OPTIONS+=--archive_segment_length=240
MP4SPLIT_OPTIONS+=--dvr_window_length=60
MP4SPLIT_OPTIONS+=--archiving=0
# MP4SPLIT_OPTIONS+=--hls.no_discontinuities
MP4SPLIT_OPTIONS+=--hls.no_audio_only
# MP4SPLIT_OPTIONS+=--hls.optimized
MP4SPLIT_OPTIONS+=--mpd.availability_start_time=$(TIMESTAMP)

# Test for channel switching times on Entone STB. Add a PAT/PMT every 100 milliseconds.
MP4SPLIT_OPTIONS+=--hls.psi=100/1000

LOOP_PUBPOINT=http://live.unified-streaming.com/loop/loop.isml?archive_segment_length=1200&dvr_window_length=900&archiving=0
TEMPLATE_PUBPOINT=http://live.unified-streaming.com/template/template.isml?archive_segment_length=240&dvr_window_length=60&archiving=0

LOOP_SOURCES=/var/www/mp4/smooth.ref/oceans-2032k.ismv \
						 /var/www/mp4/smooth.ref/oceans-1336k.ismv \
						 /var/www/mp4/smooth.ref/oceans-879k.ismv \
						 /var/www/mp4/smooth.ref/oceans-578k.ismv \
						 /var/www/mp4/smooth.ref/oceans-380k.ismv \
						 /var/www/mp4/smooth.ref/oceans-250k.ismv \
						 /var/www/mp4/smooth.ref/oceans-64k.isma
LOOP_SOURCES=video/elephant/elephant.ismv
LOOP_SOURCES=video/repomp3/repomp3.ismv
LOOP_SOURCES=video/round6/round6-1.ismv video/round6/round6-2.ismv video/round6/round6-3.ismv

/var/www3/live.unified-streaming.com/loop/loop.isml: $(LOOP_SOURCES)
	-rm /var/www3/live.unified-streaming.com/loop/*
	-mkdir /var/www3/live.unified-streaming.com/loop
	cp video/repomp3/repomp3.jpg /var/www3/live.unified-streaming.com/loop/loop.jpg
	$(MP4SPLIT) -o $@ $(MP4SPLIT_OPTIONS)
	chmod ua+w $@
	push_input_stream --chunked --tsoffset=now --daemon --loop -r -u "$(LOOP_PUBPOINT)" $+

loop: /var/www3/live.unified-streaming.com/loop/loop.isml

/var/www3/live.unified-streaming.com/template/template.isml: $(LOOP_SOURCES)
	-rm /var/www3/live.unified-streaming.com/template/*
	-mkdir /var/www3/live.unified-streaming.com/template
	cp video/repomp3/repomp3.jpg /var/www3/live.unified-streaming.com/template/template.jpg
	$(MP4SPLIT) -o $@ $(MP4SPLIT_OPTIONS) --mpd.minimum_fragment_length=4
	chmod ua+w $@
	push_input_stream --chunked --daemon --loop -r -u "$(TEMPLATE_PUBPOINT)" $+

template: /var/www3/live.unified-streaming.com/template/template.isml

# all: rtl2

cbr.mp4:
	ffmpeg -y -i $(SRC) $(FFMPEG_OPTIONS) -an $(VIDEO_OPTIONS) \
		 -b 200k -s 360x288 $@

NOWTILUS_PUBPOINT=http://live.unified-streaming.com/nowtilus/dts.isml

/var/www3/live.unified-streaming.com/nowtilus/dts.isml: video/dts/bbb.ismv
	-rm /var/www3/live.unified-streaming.com/nowtilus/*
	-mkdir /var/www3/live.unified-streaming.com/nowtilus
	$(MP4SPLIT) -o $@ $(MP4SPLIT_OPTIONS) --mpd.minimum_fragment_length=4
	chmod ua+w $@
	push_input_stream --chunked --tsoffset=now --daemon --loop -r -u "$(NOWTILUS_PUBPOINT)" $+


dts: /var/www3/live.unified-streaming.com/nowtilus/dts.isml
