-- Batch 3: rulers of Western Han, -202 to 9 CE.
-- Sources: Shiji 史记, juans 8-12; Hanshu 汉书, juans 1-12, 99 (ctext.org).
-- Liu He included as a corner case (27 days); two brief Shaodi claimants omitted
-- (see design doc, counting rule 2/3).

INSERT INTO rulers (id, personal_name, personal_name_cn, temple_name, posthumous_name, year_start, year_end, dynasty_id, predecessor_id, source, note) VALUES
(4,  'Liu Bang',   '刘邦', 'Taizu 太祖', 'Gao Huangdi 高皇帝 (Gaozu 高祖)', -202, -195, 2, NULL,
     'Shiji 史记, juan 8 高祖本纪 (ctext.org)',
     'King of Han from -206; proclaimed huangdi -202 after defeating Xiang Yu. Temple name Taizu; conventionally called Gaozu'),
(5,  'Liu Ying',   '刘盈', NULL, 'Huidi 惠帝', -195, -188, 2, 4,
     'Hanshu 汉书, juan 2 (ctext.org)',
     'Shiji gives no annals of his own; his reign sits inside the annals of Empress Dowager Lü — real power with Lü Zhi (regent, excluded by rule 3)'),
(6,  'Liu Heng',   '刘恒', 'Taizong 太宗', 'Wendi 文帝', -180, -157, 2, 5,
     'Shiji 史记, juan 10 孝文本纪 (ctext.org)',
     'Enthroned after the Lü clan was destroyed; two child claimants between Huidi and Wendi (Houshaodi) are omitted by rule 3'),
(7,  'Liu Qi',     '刘启', NULL, 'Jingdi 景帝', -157, -141, 2, 6,
     'Shiji 史记, juan 11 孝景本纪 (ctext.org)',
     'Rebellion of the seven states -154 suppressed; era names used in his reign were assigned retroactively'),
(8,  'Liu Che',    '刘彻', 'Shizong 世宗', 'Wudi 武帝', -141, -87, 2, 7,
     'Shiji 史记, juan 12 孝武本纪; Hanshu 汉书, juan 6 (ctext.org)',
     'Longest pre-modern reign here (-141 to -87); created the era-name system (see era_names table). Shiji''s Wudi annals are partly lost and refilled from later text'),
(9,  'Liu Fuling', '刘弗陵', NULL, 'Zhaodi 昭帝', -87, -74, 2, 8,
     'Hanshu 汉书, juan 7 (ctext.org)',
     'Throne at age 8; Huo Guang regent (excluded by rule 3)'),
(10, 'Liu He',     '刘贺', NULL, 'deposed, Marquis of Haihun 海昏侯', -74, -74, 2, 9,
     'Hanshu 汉书, juan 8 / 63 (ctext.org)',
     'Enthroned for 27 days in -74, deposed by Huo Guang for "1,127 misconducts". Counted by rule 2 (deposed rulers count). Tomb excavated 2011-2016'),
(11, 'Liu Bingyi', '刘询', 'Zhongzong 中宗', 'Xuandi 宣帝', -74, -48, 2, 10,
     'Hanshu 汉书, juan 8 (ctext.org)',
     'Grandson of the executed crown prince Liu Ju; grew up outside the palace. Renamed Liu Xun 刘询 in -64 to avoid taboo characters'),
(12, 'Liu Shi',    '刘奭', 'Gaozong 高宗', 'Yuandi 元帝', -48, -33, 2, 11,
     'Hanshu 汉书, juan 9 (ctext.org)',
     'Wang clan power begins: empress Wang Zhengjun''s relatives dominate the court, leading to Wang Mang'),
(13, 'Liu Ao',     '刘骜', 'Tongzong 统宗', 'Chengdi 成帝', -33, -7, 2, 12,
     'Hanshu 汉书, juan 10 (ctext.org)',
     'Favoured consort Zhao Feiyan; no surviving son — succession crisis follows'),
(14, 'Liu Xin',    '刘欣', NULL, 'Aidi 哀帝', -7, -1, 2, 13,
     'Hanshu 汉书, juan 11 (ctext.org)',
     'The "renewal" (再受命) episode -5: briefly proclaimed Han''s mandate renewed — counted as propaganda, not a new dynasty'),
(15, 'Liu Kan',    '刘衎', 'Yuanzong 元宗', 'Pingdi 平帝', -1, 6, 2, 14,
     'Hanshu 汉书, juan 12 (ctext.org)',
     'Accession 1 BCE (year -1), died 6 CE, likely poisoned by Wang Mang''s circle'),
(16, 'Liu Ying',   '刘婴', NULL, 'Ruzi Ying 孺子婴 (crown prince, not huangdi)', 6, 9, 2, 15,
     'Hanshu 汉书, juan 99 (ctext.org)',
     'Enthroned as crown prince at age 1 with Wang Mang as "acting emperor" (摄皇帝); never took the imperial title. Included by rule 2, flagged here. Wang Mang took the throne in 9 CE');

-- Era names of Wudi (id 8): the system Wudi invented; first three shown as a
-- worked example of the era_names table.
-- Source: Hanshu 汉书, juan 6 武帝纪 (ctext.org); names assigned retroactively.
INSERT INTO era_names (id, name, name_cn, year_start, year_end, ruler_id, source, note) VALUES
(1, 'Jianyuan',  '建元', -140, -135, 8, 'Hanshu 汉书, juan 6 (ctext.org)', 'First era name in Chinese history; assigned retroactively in -114'),
(2, 'Yuanguang', '元光', -134, -129, 8, 'Hanshu 汉书, juan 6 (ctext.org)', 'Name recalls the "first sighting" of the lucky comet (yuan guang)'),
(3, 'Yuanshuo', '元朔', -128, -123, 8, 'Hanshu 汉书, juan 6 (ctext.org)', 'Wudi changed era names every ~6 years ("yuan" = new epoch)');
