-- Batch 10: Five Dynasties 907-960 (Liang, Tang, Jin, Han, Zhou in the north).
-- Sources: Jiu Wudai shi 旧五代史, Xin Wudai shi 新五代史 (ctext.org).

INSERT INTO rulers (id, personal_name, personal_name_cn, temple_name, posthumous_name, year_start, year_end, dynasty_id, predecessor_id, source, note) VALUES
(141, 'Zhu Wen', '朱温', 'Taizu 太祖', 'Shenyuan 神武元圣孝皇帝', 907, 912, 22, 139,
 'Jiu Wudai shi 旧五代史, annals juan 1-2 (ctext.org)', 'Former Huang Chao rebel, then Tang governor under the name Zhu Quanzhong 朱全忠 (bestowed by Tang); murdered Emperor Zhaozong 904, took the throne 907 from Li Zhu (id 139) — cross-dynasty predecessor per design rule 4; killed by his own son'),
(142, 'Zhu Yougui', '朱友珪', NULL, 'deposed (Prince of Ying 郐王)', 912, 913, 22, 141,
 'Jiu Wudai shi 旧五代史, annals juan 12 / Xin Wudai shi (ctext.org)', 'Killed his father for the throne; overthrown by his brother''s coup within a year. Posthumously denied the imperial title by Later Liang itself'),
(143, 'Zhu Zhen', '朱瑱 (born Zhu Youzhen 朱友贞)', NULL, 'Modi 末帝', 913, 923, 22, 142, 'Jiu Wudai shi 旧五代史, annals juan 8-10 (ctext.org)', 'Last Later Liang ruler; name taboo changed his characters twice; killed himself as Li Cunxu entered Kaifeng 923'),
(144, 'Li Cunxu', '李存勖', 'Zhuangzong 庄宗', 'Guangsheng 光圣神闵孝皇帝', 923, 926, 23, 143,
 'Jiu Wudai shi 旧五代史, annals juan 27-34 (ctext.org)', 'Shatuo Turk, son of Li Keyong; destroyed Later Liang 923 claiming to restore the Tang; a great soldier who died in a mutiny over a theatre scandal (Xingjiaomen gate 926)'),
(145, 'Li Siyuan', '李嗣源', 'Mingzong 明宗', 'Shengde 和武钦孝皇帝', 926, 933, 23, 144, 'Jiu Wudai shi 旧五代史, annals juan 35-44 (ctext.org)', 'Adopted son of Li Keyong; the one decent reign of the Five Dynasties'),
(146, 'Li Conghou', '李从厚', NULL, 'Min 闵皇帝', 933, 934, 23, 145, 'Jiu Wudai shi 旧五代史, annals juan 45 (ctext.org)', 'Deposed after months by Li Congke; strangled 934'),
(147, 'Li Congke', '李从珂', NULL, 'Modi 末帝 (Feidi 废帝)', 934, 936, 23, 146, 'Jiu Wudai shi 旧五代史, annals juan 46-48 (ctext.org)', 'Adopted son; self-immolated at Luoyang with his family as Shi Jingtang and the Khitan took the city'),
(148, 'Shi Jingtang', '石敬瑭', 'Gaozu 高祖', 'Wenming Wude 文明武德大圣大孝皇帝', 936, 942, 24, 147,
 'Jiu Wudai shi 旧五代史, annals juan 75-81 (ctext.org)',
 'Called the Khitan emperor "father" and ceded the Sixteen Prefectures 幽云十六州 — the strategic wound of the Song. Posthumous form to verify against the cited juan before the demo'),
(149, 'Shi Chonggui', '石重贵', NULL, 'Chudi 出帝 (Shaodi 少帝)', 942, 947, 24, 148, 'Jiu Wudai shi 旧五代史, annals juan 81-86 (ctext.org)', 'Refused to serve Liao as grandson; the Liao took Kaifeng 947 and he died in captivity in the north'),
(150, 'Liu Zhiyuan', '刘知远', 'Gaozu 高祖', 'Ruiwen 睿文圣武昭肃孝皇帝', 947, 948, 25, 149, 'Jiu Wudai shi 旧五代史, annals juan 99-102 (ctext.org)', 'Claimed Han descent for his Shatuo dynasty; took the empty north after the Liao withdrawal'),
(151, 'Liu Chengyou', '刘承祐', NULL, 'Yin 隐皇帝', 948, 951, 25, 150, 'Jiu Wudai shi 旧五代史, annals juan 103-105 (ctext.org)', 'Massacred the great ministers; killed fleeing his own general Guo Wei'),
(152, 'Guo Wei', '郭威', 'Taizu 太祖', 'Shengshen Gongshu 圣神恭肃文武孝皇帝', 951, 954, 26, 151,
 'Jiu Wudai shi 旧五代史, annals juan 110-113 (ctext.org)',
 'Overthrew Later Han after his family was slaughtered; the Yellow Robe (黄袍加身) first draped on him by mutinying troops — later replayed on Zhao Kuangyin. Posthumous form to verify against the cited juan'),
(153, 'Chai Rong', '柴荣', 'Shizong 世宗', 'Ruiwu 睿武孝文皇帝', 954, 959, 26, 152,
 'Jiu Wudai shi 旧五代史, annals juan 114-119 (ctext.org)', 'Nephew (adopted son) of Guo Wei; conquered Huainan, smashed the Liao at Gaoping 954; died at 39 with the north reunified — Zhao Kuangyin inherits his work'),
(154, 'Chai Zongxun', '柴宗训', NULL, 'Gongdi 恭皇帝', 959, 960, 26, 153, 'Jiu Wudai shi 旧五代史, annals juan 119-120 (ctext.org)', 'Seven years old at abdication to Zhao Kuangyin (Chenqiao mutiny, 960); died young in Song care');
