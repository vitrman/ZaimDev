﻿Функция ТаблицаФормОтчета() Экспорт
	
	ОписаниеТиповСтрока = Новый ОписаниеТипов("Строка", , Новый КвалификаторыСтроки(254));
	
	МассивТипов = Новый Массив;
	МассивТипов.Добавить(Тип("Дата"));
	ОписаниеТиповДата = Новый ОписаниеТипов(МассивТипов, , Новый КвалификаторыДаты(ЧастиДаты.Дата));
	
	ТаблицаФормОтчета = Новый ТаблицаЗначений;
	ТаблицаФормОтчета.Колонки.Добавить("ФормаОтчета",        ОписаниеТиповСтрока);
	ТаблицаФормОтчета.Колонки.Добавить("ОписаниеОтчета",     ОписаниеТиповСтрока, "Утверждена",  20);
	ТаблицаФормОтчета.Колонки.Добавить("ДатаНачалоДействия", ОписаниеТиповДата,   "Действует с", 5);
	ТаблицаФормОтчета.Колонки.Добавить("ДатаКонецДействия",  ОписаниеТиповДата,   "         по", 5);
	
	НоваяФорма = ТаблицаФормОтчета.Добавить();
	НоваяФорма.ФормаОтчета        = "Форма701012009Кв1";
	НоваяФорма.ОписаниеОтчета     = "Расчет текущих платежей по земельному налогу и налогу на имущество. Форма имеет возможность выгрузки в ИС СОНО 3.99.16.7, версия репозитория от 29.07.2009 г.";
	НоваяФорма.ДатаНачалоДействия = '20090101';
	НоваяФорма.ДатаКонецДействия  = '20091231';
	
	НоваяФорма = ТаблицаФормОтчета.Добавить();
	НоваяФорма.ФормаОтчета        = "Форма701012010Кв1";
	НоваяФорма.ОписаниеОтчета     = "Расчет текущих платежей по земельному налогу и налогу на имущество. Версия шаблона ФНО для ИС СОНО: 701.01.v9.r16 от 05.02.2010 г.";
	НоваяФорма.ДатаНачалоДействия = '20091001';
	НоваяФорма.ДатаКонецДействия  = '20101231';
	
	НоваяФорма = ТаблицаФормОтчета.Добавить();
	НоваяФорма.ФормаОтчета        = "Форма701012011Кв1";
	НоваяФорма.ОписаниеОтчета     = "Расчет текущих платежей по земельному налогу и налогу на имущество. Версия шаблона ФНО для ИС СОНО: 701.01.v10.r29 от 29.12.2010 г.";
	НоваяФорма.ДатаНачалоДействия = '20110101';
	НоваяФорма.ДатаКонецДействия  = '20111231';
	
	НоваяФорма = ТаблицаФормОтчета.Добавить();
	НоваяФорма.ФормаОтчета        = "Форма701012012Кв1";
	НоваяФорма.ОписаниеОтчета     = "Расчет текущих платежей по земельному налогу и налогу на имущество. Версия шаблона ФНО для ИС СОНО: 701.01.v11.r36 от 29.12.2011 г.";
	НоваяФорма.ДатаНачалоДействия = '20120101';
	НоваяФорма.ДатаКонецДействия  = '20121231';
	
	НоваяФорма = ТаблицаФормОтчета.Добавить();
	НоваяФорма.ФормаОтчета        = "Форма701012013Кв1";
	НоваяФорма.ОписаниеОтчета     = "Расчет текущих платежей по земельному налогу и налогу на имущество. Версия шаблона ФНО для ИС СОНО: 701.01.v12.r38 от 27.12.2012 г.";
	НоваяФорма.ДатаНачалоДействия = '20130101';
	НоваяФорма.ДатаКонецДействия  = '20131231';
	
	НоваяФорма = ТаблицаФормОтчета.Добавить();
	НоваяФорма.ФормаОтчета        = "Форма701012014Кв1";
	НоваяФорма.ОписаниеОтчета     = "Расчет текущих платежей по земельному налогу и налогу на имущество. Версия шаблона ФНО для ИС СОНО: 701.01.v13.r44 от 31.12.2013 г.";
	НоваяФорма.ДатаНачалоДействия = '20140101';
	НоваяФорма.ДатаКонецДействия  = '20141231';
	
	НоваяФорма = ТаблицаФормОтчета.Добавить();
	НоваяФорма.ФормаОтчета        = "Форма701012015Кв1";
	НоваяФорма.ОписаниеОтчета     = "Расчет текущих платежей по земельному налогу и налогу на имущество. Версия шаблона ФНО для ИС СОНО: 701.01.v14.r45 от 05.01.2015 г.";
	НоваяФорма.ДатаНачалоДействия = '20150101';
	НоваяФорма.ДатаКонецДействия  = '20151231';
	
	НоваяФорма = ТаблицаФормОтчета.Добавить();
	НоваяФорма.ФормаОтчета        = "Форма701012016Кв3";
	НоваяФорма.ОписаниеОтчета     = "Расчет текущих платежей по земельному налогу и налогу на имущество. Версия шаблона ФНО для ИС СОНО: 701.01.v15.r48 от 13.08.2016 г.";
	НоваяФорма.ДатаНачалоДействия = '20160101';
	НоваяФорма.ДатаКонецДействия  = '20161231';
	
	НоваяФорма = ТаблицаФормОтчета.Добавить();
	НоваяФорма.ФормаОтчета        = "Форма701012017Кв1";
	НоваяФорма.ОписаниеОтчета     = "Расчет текущих платежей по земельному налогу и налогу на имущество. Версия шаблона ФНО для ИС СОНО: 701.01.v15.r49 от 25.12.2016 г.";
	НоваяФорма.ДатаНачалоДействия = '20170101';
	НоваяФорма.ДатаКонецДействия  = '20171231';
	
	//НоваяФорма = ТаблицаФормОтчета.Добавить();
	//НоваяФорма.ФормаОтчета        = "Форма701012018Кв1";
	//НоваяФорма.ОписаниеОтчета     = "Расчет текущих платежей по земельному налогу и налогу на имущество. Версия шаблона ФНО для ИС СОНО: 701.01.v16.r50 от 01.04.2018г .";
	//НоваяФорма.ДатаНачалоДействия = '20180101';
	//НоваяФорма.ДатаКонецДействия  = '20180331';
	
	НоваяФорма = ТаблицаФормОтчета.Добавить();
	НоваяФорма.ФормаОтчета        = "Форма701012018Кв2";
	НоваяФорма.ОписаниеОтчета     = "Расчет текущих платежей по земельному налогу и налогу на имущество. Версия шаблона ФНО для ИС СОНО: 701.01.v17.r51 от 01.04.2018г.";
	НоваяФорма.ДатаНачалоДействия = '20180101';
	НоваяФорма.ДатаКонецДействия  = '20181231';	
	
	НоваяФорма = ТаблицаФормОтчета.Добавить();
	НоваяФорма.ФормаОтчета        = "Форма701012019Кв1";
	НоваяФорма.ОписаниеОтчета     = "Расчет текущих платежей по земельному налогу и налогу на имущество. Версия шаблона ФНО для ИС СОНО: 701.01.v17.r52 от 26.12.2018г.";
	НоваяФорма.ДатаНачалоДействия = '20190101';
	НоваяФорма.ДатаКонецДействия  = '20191231';
	
	//НоваяФорма = ТаблицаФормОтчета.Добавить();
	//НоваяФорма.ФормаОтчета        = "Форма701012020Кв1";
	//НоваяФорма.ОписаниеОтчета     = "Расчет текущих платежей по земельному налогу и налогу на имущество. Версия шаблона ФНО для ИС СОНО: 701.01.v17.r53 от 24.12.2019г.";
	//НоваяФорма.ДатаНачалоДействия = '20200101';
	//НоваяФорма.ДатаКонецДействия  = РегламентированнаяОтчетностьКлиентСервер.ПустоеЗначениеТипа(Тип("Дата"));
	
	НоваяФорма = ТаблицаФормОтчета.Добавить();
	НоваяФорма.ФормаОтчета        = "Форма701012020Кв2";
	НоваяФорма.ОписаниеОтчета     = "Расчет текущих платежей по земельному налогу и налогу на имущество. Версия шаблона ФНО для ИС СОНО: 701.01.v18.r57 от 21.12.2020г.";
	НоваяФорма.ДатаНачалоДействия = '20200101';
	НоваяФорма.ДатаКонецДействия  = '20201231';
	
	НоваяФорма = ТаблицаФормОтчета.Добавить();
	НоваяФорма.ФормаОтчета        = "Форма701012021Кв1";
	НоваяФорма.ОписаниеОтчета     = "Расчет текущих платежей по земельному налогу и налогу на имущество. Версия шаблона ФНО для ИС СОНО: 701.01.v19.r58 от 23.02.2021г.";
	НоваяФорма.ДатаНачалоДействия = '20210101';
	НоваяФорма.ДатаКонецДействия  = '20211231';
	
	НоваяФорма = ТаблицаФормОтчета.Добавить();
	НоваяФорма.ФормаОтчета        = "Форма701012022Кв1";
	НоваяФорма.ОписаниеОтчета     = "Расчет текущих платежей по земельному налогу и налогу на имущество. Версия шаблона ФНО для ИС СОНО: 701.01.v19.r59 от 23.12.2021.";
	НоваяФорма.ДатаНачалоДействия = '20220101';
	НоваяФорма.ДатаКонецДействия  = '20221231';
	
	НоваяФорма = ТаблицаФормОтчета.Добавить();
	НоваяФорма.ФормаОтчета        = "Форма701012023Кв1";
	НоваяФорма.ОписаниеОтчета     = "Расчет текущих платежей по земельному налогу и налогу на имущество. Версия шаблона ФНО для ИС СОНО: 701.01.v19.r61 от 26.12.2023 г.";
	НоваяФорма.ДатаНачалоДействия = '20230101';
	НоваяФорма.ДатаКонецДействия  = РегламентированнаяОтчетностьКлиентСервер.ПустоеЗначениеТипа(Тип("Дата"));
	
	Возврат ТаблицаФормОтчета;
	
КонецФункции


