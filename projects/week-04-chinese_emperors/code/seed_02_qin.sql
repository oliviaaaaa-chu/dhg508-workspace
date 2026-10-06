-- Batch 2: rulers of Qin, 221-206 BCE (challenge 1 starts here).
-- Source: Shiji 史记, juan 6 秦始皇本纪 (ctext.org).

INSERT INTO rulers (id, personal_name, personal_name_cn, temple_name, posthumous_name, year_start, year_end, dynasty_id, predecessor_id, source, note) VALUES
(1, 'Ying Zheng', '嬴政', NULL, 'Shi Huangdi 始皇帝', -221, -210, 1, NULL,
    'Shiji 史记, juan 6 秦始皇本纪 (ctext.org)',
    'First to adopt the title huangdi 皇帝; abolished posthumous names for successors, numbering them Shi, Er Shi... King of Qin from -247; unified China -221. Died on tour in -210'),
(2, 'Ying Huhai', '胡亥', NULL, 'Er Shi Huangdi 二世皇帝', -210, -207, 1, 1,
    'Shiji 史记, juan 6 秦始皇本纪 (ctext.org)',
    'Younger son of Shi Huang; placed on the throne by Zhao Gao and Li Si with a forged testament. Elder brother Fusu forced to suicide. Forced by Zhao Gao to kill himself in -207'),
(3, 'Ying Ziying', '嬴子婴', NULL, 'King of Qin 秦王', -207, -206, 1, 2,
    'Shiji 史记, juan 6 秦始皇本纪 (ctext.org)',
    'Held the title King of Qin, not huangdi — the empire had already split. Surrendered to Liu Bang after 46 days; killed by Xiang Yu. Counted by rule 1 (state''s supreme title), flagged here');
