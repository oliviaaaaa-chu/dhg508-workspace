-- Batch 6: Jin, Western 265-316 and Eastern 317-420.
-- Source: Jinshu 晋书 (Tang-compiled) (ctext.org).

INSERT INTO rulers (id, personal_name, personal_name_cn, temple_name, posthumous_name, year_start, year_end, dynasty_id, predecessor_id, source, note) VALUES
(44, 'Sima Yan', '司马炎', 'Shizu 世祖', 'Wudi 武皇帝', 265, 290, 8, 37,
 'Jinshu 晋书, annals juan 3 (ctext.org)', 'Received Wei''s abdication; reunited China 280 by conquering Wu; his death starts the War of the Eight Princes'),
(45, 'Sima Zhong', '司马衷', NULL, 'Huidi 惠皇帝', 290, 307, 8, 44,
 'Jinshu 晋书, annals juan 4 (ctext.org)', 'Developmentally unable to rule ("Why not eat meat porridge?" 何不食肉糜 is attributed to him); power with Empress Jia, then the Eight Princes war'),
(46, 'Sima Chi', '司马炽', NULL, 'Huaidi 怀皇帝', 307, 311, 8, 45, 'Jinshu 晋书, annals juan 5 (ctext.org)', 'Captured at Luoyang in the Disaster of Yongjia (311), poisoned by Han Zhao 313'),
(47, 'Sima Ye', '司马邺', NULL, 'Mindi 愍皇帝', 313, 316, 8, 46, 'Jinshu 晋书, annals juan 5 (ctext.org)', 'Surrendered Chang''an to Han Zhao 316 — end of Western Jin'),
(48, 'Sima Rui', '司马睿', 'Zhongzong 中宗', 'Yuandi 元皇帝', 317, 322, 9, 47,
 'Jinshu 晋书, annals juan 6 (ctext.org)', 'Proclaimed at Jiankang; state exists in name only south of the Yangzi — "the king and the horse share the world" (王与马，共天下)'),
(49, 'Sima Shao', '司马绍', 'Suzu 肃祖', 'Mingdi 明皇帝', 322, 325, 9, 48, 'Jinshu 晋书, annals juan 6 (ctext.org)', 'Broke Wang Dun''s rebellion; died young at 27'),
(50, 'Sima Yan', '司马衍', 'Xianzong 显宗', 'Chengdi 成皇帝', 325, 342, 9, 49,
 'Jinshu 晋书, annals juan 7 (ctext.org)', 'Same romanisation as Jin Wudi 司马炎 (Sima Yan) — different person and different character 衍/炎; regency of Yu Liang'),
(51, 'Sima Yue', '司马岳', NULL, 'Kangdi 康皇帝', 342, 344, 9, 50, 'Jinshu 晋书, annals juan 8 (ctext.org)', 'Brother of Chengdi; two years only'),
(52, 'Sima Dan', '司马聃', 'Xiaozong 孝宗', 'Mudi 穆皇帝', 344, 361, 9, 51, 'Jinshu 晋书, annals juan 8 (ctext.org)', 'Huan Wen''s northern expeditions fought under his name'),
(53, 'Sima Pi', '司马丕', NULL, 'Aidi 哀皇帝', 361, 365, 9, 52, 'Jinshu 晋书, annals juan 8 (ctext.org)', 'Died from elixir poisoning ( Daoist immortality drugs)'),
(54, 'Sima Yi', '司马奕', NULL, 'Deposed Duke of Haixi 海西公', 365, 371, 9, 53,
 'Jinshu 晋书, annals juan 8 (ctext.org)', 'Deposed by Huan Wen on fabricated charges (impotence, sons not his own); renames himself Duke of Haixi. Same romanisation as Jin Wudi''s father Sima Yi 司马懿 — different person'),
(55, 'Sima Yu', '司马昱', 'Taizong 太宗', 'Jianwendi 简文皇帝', 371, 372, 9, 54, 'Jinshu 晋书, annals juan 9 (ctext.org)', 'Huan Wen''s puppet; reigned 8 months'),
(56, 'Sima Yao', '司马曜', 'Liezu 烈宗', 'Xiaowudi 孝武皇帝', 372, 396, 9, 55, 'Jinshu 晋书, annals juan 9 (ctext.org)', 'Won the Battle of Feishui 383; smothered by a drunken prank of his consort Zhang'),
 (57, 'Sima Dezong', '司马德宗', NULL, 'Andi 安皇帝', 396, 419, 9, 56, 'Jinshu 晋书, annals juan 10 (ctext.org)', 'Could not speak; real power passed through regencies — Sima Daozi, Huan Xuan (usurper 403-404), then Liu Yu (刘裕) from 404'),
(58, 'Sima Dewen', '司马德文', NULL, 'Gongdi 恭皇帝', 419, 420, 9, 57, 'Jinshu 晋书, annals juan 10 (ctext.org)', 'Last Jin emperor; "willingly" abdicated to Liu Yu (the same romanisation as Liu Song''s founder 刘裕) — Liu Song begins 420');
