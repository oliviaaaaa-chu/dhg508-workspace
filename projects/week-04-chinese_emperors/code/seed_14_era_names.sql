-- Batch 14: era names (selected coverage). Complete for Ming and Qing (where
-- reign names are the standard way to refer to emperors); iconic selections
-- for Han, Tang and Song. More can be added later as new rows.
-- Sources: Jiu Tangshu 旧唐书, Songshi 宋史, Mingshi 明史, Qingshi gao 清史稿.

INSERT INTO era_names (id, name, name_cn, year_start, year_end, ruler_id, source, note) VALUES
(4,  'Zhenguan', '贞观', 627, 649, 120, 'Jiu Tangshu 旧唐书, annals juan 2-3 (ctext.org)', 'The model "good governance" era (贞观之治) — the yardstick later emperors were judged against'),
(5,  'Kaiyuan', '开元', 713, 741, 125, 'Jiu Tangshu 旧唐书, annals juan 8 (ctext.org)', 'Peak of the Tang; poets Li Bai and Du Fu under it'),
(6,  'Tianbao', '天宝', 742, 756, 125, 'Jiu Tangshu 旧唐书, annals juan 9 (ctext.org)', 'Ends with the An Lushan rebellion 755 — one reign, two eras, the fall in between'),
(7,  'Jingkang', '靖康', 1126, 1127, 212, 'Songshi 宋史, annals juan 23 (ctext.org)', 'The Jingkang catastrophe: two emperors taken north — the era name became a byword for national humiliation'),
(8,  'Hongwu', '洪武', 1368, 1398, 253, 'Mingshi 明史, annals juan 1-3 (ctext.org)', 'Ming founder''s era; from here on, one reign name per emperor becomes the rule'),
(9,  'Jianwen', '建文', 1399, 1402, 254, 'Mingshi 明史, annals juan 4 (ctext.org)', 'The era name itself was suppressed under Yongle for decades'),
(10, 'Yongle', '永乐', 1403, 1424, 255, 'Mingshi 明史, annals juan 5-8 (ctext.org)', 'Zheng He''s voyages and the move to Beijing'),
(11, 'Hongxi', '洪熙', 1425, 1425, 256, 'Mingshi 明史, annals juan 8 (ctext.org)', 'One year'),
(12, 'Xuande', '宣德', 1426, 1435, 257, 'Mingshi 明史, annals juan 9-10 (ctext.org)', 'Xuande censors — the porcelain collectors'' era'),
(13, 'Zhengtong', '正统', 1436, 1449, 258, 'Mingshi 明史, annals juan 10-11 (ctext.org)', 'Ends with the Tumu capture of the emperor'),
(14, 'Jingtai', '景泰', 1450, 1457, 259, 'Mingshi 明史, annals juan 11 (ctext.org)', 'The brother-reign during the first emperor''s captivity'),
(15, 'Tianshun', '天顺', 1457, 1464, 258, 'Mingshi 明史, annals juan 12-13 (ctext.org)', 'The restoration — same emperor as Zhengtong (id 258), second reign'),
(16, 'Chenghua', '成化', 1465, 1487, 260, 'Mingshi 明史, annals juan 13-14 (ctext.org)', 'Chenghua "chicken cups"; secret police of Wan Guifei'),
(17, 'Hongzhi', '弘治', 1488, 1505, 261, 'Mingshi 明史, annals juan 15 (ctext.org)', 'The model virtuous reign of the mid-Ming'),
(18, 'Zhengde', '正德', 1506, 1521, 262, 'Mingshi 明史, annals juan 16 (ctext.org)', 'The playboy reign'),
(19, 'Jiajing', '嘉靖', 1522, 1566, 263, 'Mingshi 明史, annals juan 17-18 (ctext.org)', '45 years; the emperor absent from court for decades'),
(20, 'Longqing', '隆庆', 1567, 1572, 264, 'Mingshi 明史, annals juan 19 (ctext.org)', 'Sea trade opened'),
(21, 'Wanli', '万历', 1573, 1620, 265, 'Mingshi 明史, annals juan 20-22 (ctext.org)', 'Longest Ming reign; the Mingshi blames it for the fall'),
(22, 'Taichang', '泰昌', 1620, 1620, 266, 'Mingshi 明史, annals juan 21 (ctext.org)', 'One month'),
(23, 'Tianqi', '天启', 1621, 1627, 267, 'Mingshi 明史, annals juan 22 (ctext.org)', 'The carpenter emperor; Wei Zhongxian'),
(24, 'Chongzhen', '崇祯', 1628, 1644, 268, 'Mingshi 明史, annals juan 23-24 (ctext.org)', 'Ends with the emperor''s suicide on Meishan'),
(25, 'Chongde', '崇德', 1636, 1643, 270, 'Qingshi gao 清史稿, annals juan 2-3', 'The era from which the state is called Qing 清 (before: Tiancong 天聪 1627-1636, khan years)'),
(26, 'Shunzhi', '顺治', 1644, 1661, 271, 'Qingshi gao 清史稿, annals juan 4-6', 'Qing rule of China proper begins'),
(27, 'Kangxi', '康熙', 1662, 1722, 272, 'Qingshi gao 清史稿, annals juan 6-8', '61 years — the longest era in this database'),
(28, 'Yongzheng', '雍正', 1723, 1735, 273, 'Qingshi gao 清史稿, annals juan 9-10', 'Fiscal rigour and the succession-secret box'),
(29, 'Qianlong', '乾隆', 1736, 1795, 274, 'Qingshi gao 清史稿, annals juan 10-16', 'Abdicated in 1796 to avoid out-reigning Kangxi; kept power to 1799'),
(30, 'Jiaqing', '嘉庆', 1796, 1820, 275, 'Qingshi gao 清史稿, annals juan 16-17', 'Heshen executed in the first weeks'),
(31, 'Daoguang', '道光', 1821, 1850, 276, 'Qingshi gao 清史稿, annals juan 17-19', 'First Opium War under this era'),
(32, 'Xianfeng', '咸丰', 1851, 1861, 277, 'Qingshi gao 清史稿, annals juan 19-20', 'Taiping rising; Cixi enters the picture'),
(33, 'Tongzhi', '同治', 1862, 1874, 278, 'Qingshi gao 清史稿, annals juan 21-22', 'The "Tongzhi restoration" was a joint regency of two dowagers'),
(34, 'Guangxu', '光绪', 1875, 1908, 279, 'Qingshi gao 清史稿, annals juan 23-25', 'Hundred Days 1898 under this era'),
(35, 'Xuantong', '宣统', 1909, 1912, 280, 'Qingshi gao 清史稿, annals juan 25; abdication edict 12 Feb 1912', 'The last era name in Chinese imperial history');
