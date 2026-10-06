-- Batch 5: the Three Kingdoms, 220-280.
-- Source: Sanguozhi 三国志 by Chen Shou (ctext.org); posthumous names mostly
-- from later standard histories (Sanguozhi is terse on this).

INSERT INTO rulers (id, personal_name, personal_name_cn, temple_name, posthumous_name, year_start, year_end, dynasty_id, predecessor_id, source, note) VALUES
(33, 'Cao Pi', '曹丕', 'Gaozu 高祖', 'Wendi 文皇帝', 220, 226, 5, 32,
 'Sanguozhi 三国志, Wei shu annals juan 2 (ctext.org)',
 'Received the abdication of Han Xiandi in the 12th month of 220 — the model for every later "abdication" coup'),
(34, 'Cao Rui', '曹叡', 'Liezu 烈祖', 'Mingdi 明皇帝', 226, 239, 5, 33, 'Sanguozhi 三国志, Wei shu annals juan 3 (ctext.org)', 'Only Wei ruler with a temple name other than the two ancestors; huge building programme, noted by critics'),
(35, 'Cao Fang', '曹芳', NULL, 'Deposed, Duke of Qi 齐王', 239, 254, 5, 34, 'Sanguozhi 三国志, Wei shu annals juan 4 (ctext.org)', 'Child of unclear parentage (adopted heir of Rui); deposed by Sima Shi'),
(36, 'Cao Mao', '曹髦', NULL, 'Duke of Gaoguixiang 高贵乡公', 254, 260, 5, 35,
 'Sanguozhi 三国志, Wei shu annals juan 4 (ctext.org)',
 'Killed charging Sima Zhao''s men — said "Sima Zhao''s heart is known to every passer-by" (司马昭之心，路人皆知). Rode out to battle personally, died 260'),
(37, 'Cao Huan', '曹奂', NULL, 'Yuandi 元皇帝', 260, 266, 5, 36, 'Sanguozhi 三国志, Wei shu annals juan 4 (ctext.org)', 'Abdicated to Sima Yan; Wei ends Dec 265 / Feb 266 by Western reckoning — hence the 265/266 overlap in this database'),
(38, 'Liu Bei', '刘备', 'Liezu 烈祖', 'Zhaolie 昭烈皇帝', 221, 223, 6, NULL,
 'Sanguozhi 三国志, Shu shu annals juan 2 (ctext.org)',
 'Claimed the Han succession after (false) reports of Han Xiandi''s death; never controlled the whole empire he claimed to inherit'),
(39, 'Liu Shan', '刘禅', NULL, 'Houzhu 后主 (Xiaohuai 孝怀皇帝, bestowed by Han Zhao)', 223, 263, 6, 38,
 'Sanguozhi 三国志, Shu shu annals juan 3 (ctext.org)',
 'Surrendered to Wei 263 ("lacking all worry", 乐不思蜀). The Xiaohuai title was bestowed posthumously by Liu Yuan of Han Zhao — a rival state''s gesture'),
(40, 'Sun Quan', '孙权', 'Taizu 太祖', 'Dadi 大皇帝', 229, 252, 7, NULL,
 'Sanguozhi 三国志, Wu shu annals juan 2 (ctext.org)',
 'King of Wu from 222 under Wei suzerainty; took the imperial title 229 — the last of the three claimants to do so'),
(41, 'Sun Liang', '孙亮', NULL, 'Shaodi 少帝, deposed as Prince of Guiji 会稽王', 252, 258, 7, 40, 'Sanguozhi 三国志, Wu shu annals juan 3 (ctext.org)', 'Child emperor; deposed by chancellor Sun Chen'),
(42, 'Sun Xiu', '孙休', NULL, 'Jingdi 景皇帝', 258, 264, 7, 41, 'Sanguozhi 三国志, Wu shu annals juan 3 (ctext.org)', 'Killed Sun Chen with the help of Zhang Bu and Ding Feng'),
(43, 'Sun Hao', '孙皓', NULL, 'Modi 末帝 (Marquis of Guiming 归命侯)', 264, 280, 7, 42, 'Sanguozhi 三国志, Wu shu annals juan 3 (ctext.org)', 'Last Three Kingdoms ruler; surrendered to Jin 280, ending the division');
