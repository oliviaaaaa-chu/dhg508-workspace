-- Batch 4: Xin (9-23), and Eastern Han 25-220 with its contested claimants.
-- Sources: Hanshu 汉书, juan 99; Hou Hanshu 后汉书, annals juans 1-9 (ctext.org).

INSERT INTO rulers (id, personal_name, personal_name_cn, temple_name, posthumous_name, year_start, year_end, dynasty_id, predecessor_id, source, note) VALUES
(17, 'Wang Mang', '王莽', NULL, 'Xin Huangdi 新皇帝 (no standard posthumous name)', 9, 23, 3, 16,
 'Hanshu 汉书, juan 99 (ctext.org)',
 'Usurper, cousin of Empress Wang; took the throne from Ruzi Ying in 9 CE. Killed at Chang''an, 23 CE. Reign dates overlap the wars of the Red Eyebrows and the Gengshi restoration'),

(18, 'Liu Xuan', '刘玄', NULL, 'Gengshi Huangdi 更始皇帝', 23, 25, 4, 17,
 'Hou Hanshu 后汉书, juan 11 刘玄刘盆子列传 (ctext.org)',
 'Restored the Han title 23-25, between Wang Mang and Guangwu. Claimant, not always counted in Han successions (rule 2); placed under Eastern Han as the preceding Han claimant'),

(19, 'Liu Xiu',  '刘秀', 'Shizong 世祖', 'Guangwu 光武皇帝', 25, 57, 4, 18,
 'Hou Hanshu 后汉书, annals juan 1 (ctext.org)', 'Restored the Han; moved capital to Luoyang. Defeated the Red Eyebrows by 27 CE'),
(20, 'Liu Zhuang', '刘庄', 'Xianzong 显宗', 'Ming 孝明皇帝', 57, 75, 4, 19, 'Hou Hanshu 后汉书, annals juan 2 (ctext.org)', 'Buddhism said to enter China in his reign (White Horse temple legend)'),
(21, 'Liu Da', '刘炟', 'Suzong 肃宗', 'Zhang 孝章皇帝', 75, 88, 4, 20, 'Hou Hanshu 后汉书, annals juan 3 (ctext.org)', 'Paired with Mingdi as the model reign of the restored Han (Ming-Zhang flourishing)'),
(22, 'Liu Zhao', '刘肇', 'Muzong 穆宗', 'He 孝和皇帝', 88, 106, 4, 21, 'Hou Hanshu 后汉书, annals juan 4 (ctext.org)', 'Child on throne; eunuch politics begins with his coup against the Dou clan'),
(23, 'Liu Long', '刘隆', NULL, 'Shang 孝殇皇帝', 106, 106, 4, 22, 'Hou Hanshu 后汉书, annals juan 4 (ctext.org)', 'Enthroned ~100 days old, died before his second birthday — youngest emperor on record here'),
(24, 'Liu Hu', '刘祜', 'Gongzong 恭宗', 'An 孝安皇帝', 106, 125, 4, 22, 'Hou Hanshu 后汉书, annals juan 5 (ctext.org)', 'Enthroned months after Zhaodi, so 105/106 is partly overlap; throne due to Empress Dowager Deng'),
(25, 'Liu Yi', '刘懿', NULL, 'Marquess of Beixiang 北乡侯', 125, 125, 4, 24,
 'Hou Hanshu 后汉书, annals juan 5 / 10 (ctext.org)',
 'Enthroned by eunuchs after Andi''s death, died after ~7 months, no posthumous imperial name. Counted by rule 2 (deposed rulers), flagged as contested'),
(26, 'Liu Bao', '刘保', 'Jingzong 敬宗', 'Shun 孝顺皇帝', 125, 144, 4, 25, 'Hou Hanshu 后汉书, annals juan 6 (ctext.org)', 'Throne won back from the eunuch faction by palace coup at age 11'),
(27, 'Liu Bing', '刘炳', NULL, 'Chong 孝冲皇帝', 144, 145, 4, 26, 'Hou Hanshu 后汉书, annals juan 6 (ctext.org)', 'Two-year-old emperor; died within a year'),
(28, 'Liu Zuan', '刘缵', NULL, 'Zhi 孝质皇帝', 145, 146, 4, 27, 'Hou Hanshu 后汉书, annals juan 6 (ctext.org)', 'Called Liang Ji "the domineering general" and was poisoned by him, aged 8'),
(29, 'Liu Zhi', '刘志', 'Weizong 威宗', 'Huan 孝桓皇帝', 146, 168, 4, 28, 'Hou Hanshu 后汉书, annals juan 7 (ctext.org)', 'Enthroned by Liang Ji, whom he then destroyed with the Five Eunuchs; first Great Proscription of scholars'),
(30, 'Liu Hong', '刘宏', NULL, 'Ling 孝灵皇帝', 168, 189, 4, 29, 'Hou Hanshu 后汉书, annals juan 8 (ctext.org)', 'Second Great Proscription 169; sold offices openly; Yellow Turbans rose 184'),
(31, 'Liu Bian', '刘辩', NULL, 'Shaodi 少帝 (Prince of Hongnong 弘农王)', 189, 189, 4, 30,
 'Hou Hanshu 后汉书, annals juan 9 献帝纪 (ctext.org)',
 'Enthroned Apr 189 after Lingdi; deposed by Dong Zhuo Sep 189, forced to suicide 190. Often omitted from the "12 emperors" count; included by rule 2'),
(32, 'Liu Xie', '刘协', NULL, 'Xian 孝献皇帝', 189, 220, 4, 31, 'Hou Hanshu 后汉书, annals juan 9 (ctext.org)', 'Puppet of Dong Zhuo, then Cao Cao ("coffers held under the name of the emperor" 挟天子以令诸侯); abdicated to Cao Pi 220, ending the Han');
