PYTHONPATH=. python ./post_process/deoverlap.py \
    --pred_score ./data/work_dir/cfg_test_0.7_0.75/pretrained_gcn_d.npz \
    --th_pos -1 \
    --th_iou 1 \
    --force
