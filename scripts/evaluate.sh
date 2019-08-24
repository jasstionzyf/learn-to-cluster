PYTHONPATH=. python evaluation/evaluate.py \
    --metric 'pairwise' \
    --gt_labels /data1/mlib_data/features/vcg_clustering/labels/vcg_test.meta \
    --pred_labels ./data/work_dir/cfg_test_0.7_0.75/pretrained_gcn_d_th_iou_1.0_pos_-1.0_pred_label.txt
