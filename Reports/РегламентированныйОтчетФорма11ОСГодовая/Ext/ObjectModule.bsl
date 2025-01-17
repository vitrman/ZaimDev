﻿
Функция ТаблицаФормОтчета() Экспорт
	
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
	НоваяФорма.ФормаОтчета        = "ФормаОС112014Кв4";
	НоваяФорма.ОписаниеОтчета     = "Утверждена приказом Председателя Агентства Республики Казахстан по статистике от 01 ноября 2012 года №306"; 
	НоваяФорма.ДатаНачалоДействия = '20140101';
	НоваяФорма.ДатаКонецДействия  = '20141231';
	
	НоваяФорма = ТаблицаФормОтчета.Добавить();
	НоваяФорма.ФормаОтчета        = "ФормаОС112015Кв4";
	НоваяФорма.ОписаниеОтчета     = "Утверждена Приказом Председателя Комитета по статистике Министерства национальной экономики Республики Казахстан от 7 октября 2015 года № 154"; 
	НоваяФорма.ДатаНачалоДействия = '20150101';
	НоваяФорма.ДатаКонецДействия  = '20151231';
	
	НоваяФорма = ТаблицаФормОтчета.Добавить();
	НоваяФорма.ФормаОтчета        = "ФормаОС112016Кв4";
	НоваяФорма.ОписаниеОтчета     = "Утверждена Приказом Председателя Комитета по статистике Министерства национальной экономики Республики Казахстан от 7 октября 2015 года № 154"; 
	НоваяФорма.ДатаНачалоДействия = '20160101';
	НоваяФорма.ДатаКонецДействия  = '20161231';
	
	НоваяФорма = ТаблицаФормОтчета.Добавить();
	НоваяФорма.ФормаОтчета        = "ФормаОС112017Кв4";
	НоваяФорма.ОписаниеОтчета     = "Утверждена Приказом Председателя Комитета по статистике Министерства национальной экономики Республики Казахстан от 10 ноября 2017 года № 165"; 
	НоваяФорма.ДатаНачалоДействия = '20170101';
	НоваяФорма.ДатаКонецДействия  = '20201231';
	
	НоваяФорма = ТаблицаФормОтчета.Добавить();
	НоваяФорма.ФормаОтчета        = "ФормаОС112021Кв4";
	НоваяФорма.ОписаниеОтчета     = "Утверждена Приказом Председателя Комитета по статистике Министерства национальной экономики Республики Казахстан от 4 февраля 2020 года № 14"; 
	НоваяФорма.ДатаНачалоДействия = '20210101';
	НоваяФорма.ДатаКонецДействия  = '20211231'; 
	
	НоваяФорма = ТаблицаФормОтчета.Добавить();
	НоваяФорма.ФормаОтчета        = "ФормаОС112022Кв4";
	НоваяФорма.ОписаниеОтчета     = "Утверждена Приказом Председателя Комитета по статистике Министерства национальной экономики Республики Казахстан от 4 февраля 2020 года № 14"; 
	НоваяФорма.ДатаНачалоДействия = '20220101';
	НоваяФорма.ДатаКонецДействия  = РегламентированнаяОтчетностьКлиентСервер.ПустоеЗначениеТипа(Тип("Дата"));

	
	Возврат ТаблицаФормОтчета;
	
КонецФункции

