#!/bin/bash
# Copyright (C) 2020 THL A29 Limited, a Tencent company.
# All rights reserved.
# Licensed under the BSD 3-Clause License (the "License"); you may
# not use this file except in compliance with the License. You may
# obtain a copy of the License at
# https://opensource.org/licenses/BSD-3-Clause
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" basis,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or
# implied. See the License for the specific language governing
# permissions and limitations under the License.
# See the AUTHORS file for names of contributors.

set -e
FRAMEWORKS=("turbo-transformers" "torch")
# pip install onnxruntime-gpu before benchmarking onnxrt
# FRAMEWORKS=("onnxruntime")
SEQ_LEN=(300)
BATCH_SIZE=(20)
N=150
MODEL="bert-large-uncased"
for batch_size in ${BATCH_SIZE[*]}
do
  for seq_len in ${SEQ_LEN[*]}
  do
    for framework in ${FRAMEWORKS[*]}
    do
      nvprof --csv --trace gpu python gpu_benchmark.py ${MODEL} --seq_len=${seq_len} --batch_size=${batch_size}\
          -n ${N} --framework=${framework}
    done
  done
done
