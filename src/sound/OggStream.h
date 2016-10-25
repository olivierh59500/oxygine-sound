#pragma once
#include <vector>
#include "core/Object.h"
#include "core/file.h"
#include "ivorbisfile.h"
#include "MemoryStream.h"
#include "SoundStream.h"


namespace oxygine
{
    DECLARE_SMART(OggStream, spOggStream);
    class OggStream: public SoundStream
    {
    public:
        OggStream();
        ~OggStream();

        bool init(const void* data, unsigned int len);
        bool init(const char* path);
        bool init(file::handle h, bool close);

        void reset();
        void release();

        int                 getCurrentPCM() const;
        int                 getCurrentMS() const;
        int                 getPosition() const { return getCurrentMS(); }
        int                 seekPCM(int pcm);
        int                 seekMS(int ms);
        void                setPosition(int ms) { seekMS(ms); }
        int                 decodeNextBlock(bool looped, void* data, int bufferSize);
        void                decodeAll(void* data, int bufferSize);

    private:
        bool                _init(const ov_callbacks& cb, void* userData);


        fileRMem            _memStream;
        OggVorbis_File      _vorbisFile;

        vorbis_info* _info;

        int _section;
    };
}