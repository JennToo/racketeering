#!/bin/bash

set -ex

find . -name '*.rkt' -exec raco fmt --width 80 -i '{}' ';' -print
