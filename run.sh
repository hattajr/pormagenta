#!/bin/bash
music_vae_generate \
        --config=groovae_4bar \
        --checkpoint_file=groovae_4bar.tar \
        --mode=sample \
        --num_outputs=4 \
        --output_dir=$PWD/results