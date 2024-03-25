﻿
Функция Test()
	
	Структура = Новый Структура("Success, Message", Истина, "");
	Структура.Success = Истина;
	Структура.Message = "Соединение установлено.";
	
	Возврат ОбменДаннымиМобильноеПриложениеМаркировкаИСМПТК.Сериализовать(Структура);
	
КонецФункции

Функция DataTransfer(SerializedDataStructure)
	
	Структура = ОбменДаннымиМобильноеПриложениеМаркировкаИСМПТК.Десериализовать(SerializedDataStructure);
	Документ  = ОбменДаннымиМобильноеПриложениеМаркировкаИСМПТК.НайтиДокументСканированиеТоваровПоИдентификатору(Структура.Identifier);
	
	Если Документ = Неопределено Тогда
		
		ДокументСканированиеТоваров = Документы.СканированиеТоваровИСМПТК.СоздатьДокумент();
		ДокументСканированиеТоваров.Дата = Структура.Date;
		ДокументСканированиеТоваров.Идентификатор = Структура.Identifier; 
		
	Иначе
		
		ДокументСканированиеТоваров = Документ.ПолучитьОбъект();
		ДокументСканированиеТоваров.НоменклатураЗакодированная.Очистить();
		
	КонецЕсли;
	
	Для Каждого Строка Из Структура.Nomenclature Цикл
		
		СтрокаДокумента = ДокументСканированиеТоваров.НоменклатураЗакодированная.Добавить();
		СтрокаДокумента.КодМаркировки = Строка.CodeMarking;
				
	КонецЦикла;
	
	ДокументСканированиеТоваров.Наименование = Структура.Name;
	ДокументСканированиеТоваров.Записать(РежимЗаписиДокумента.Проведение);
	
	Структура = Новый Структура("Success, Message", Истина, "");
	Структура.Success = Истина;
	Структура.Message = "Передан документ Сканирование товаров " + ДокументСканированиеТоваров.Номер + " " + ДокументСканированиеТоваров.Дата;
	
	Возврат ОбменДаннымиМобильноеПриложениеМаркировкаИСМПТК.Сериализовать(Структура);
	
КонецФункции

Функция GiveAllDocs()
	
	Запрос = Новый Запрос;
	Запрос.Текст = 
	"ВЫБРАТЬ
	|	СканированиеТоваровИСМПТК.Наименование КАК Наименование,
	|	СканированиеТоваровИСМПТК.Дата КАК Дата,
	|	СканированиеТоваровИСМПТК.Номер КАК Номер
	|ИЗ
	|	Документ.СканированиеТоваровИСМПТК КАК СканированиеТоваровИСМПТК";
	
	Выборка = Запрос.Выполнить().Выбрать();
	
	ТЗ = Новый ТаблицаЗначений;
	ТЗ.Колонки.Добавить("Name",	  Новый ОписаниеТипов("Строка"));
	ТЗ.Колонки.Добавить("Date",	  Новый ОписаниеТипов("Дата"));
	ТЗ.Колонки.Добавить("Number", Новый ОписаниеТипов("Строка"));
	
	Пока Выборка.Следующий() Цикл
		Строка = ТЗ.Добавить();
		Строка.Name   = Выборка.Наименование;
		Строка.Date   = Выборка.Дата;
		Строка.Number = Выборка.Номер;
	КонецЦикла;
	
	Возврат ОбменДаннымиМобильноеПриложениеМаркировкаИСМПТК.Сериализовать(ТЗ);
	
КонецФункции

Функция GiveDocumentMarkingCodes(Document)
	
	НомерДокумента = ОбменДаннымиМобильноеПриложениеМаркировкаИСМПТК.Десериализовать(Document);
	
	Запрос = Новый Запрос;
	Запрос.Текст = 
	"ВЫБРАТЬ
	|	СканированиеТоваровИСМПТКНоменклатураЗакодированная.КодМаркировки КАК КодМаркировки
	|ИЗ
	|	Документ.СканированиеТоваровИСМПТК.НоменклатураЗакодированная КАК СканированиеТоваровИСМПТКНоменклатураЗакодированная
	|ГДЕ
	|	СканированиеТоваровИСМПТКНоменклатураЗакодированная.Ссылка.Номер = &Номер";
	
	Запрос.УстановитьПараметр("Номер", НомерДокумента); 
	Выборка = Запрос.Выполнить().Выбрать();
	Список  = Новый СписокЗначений;
	
	Пока Выборка.Следующий() Цикл
		Список.Добавить(Выборка.КодМаркировки);
	КонецЦикла;
	
	Возврат ОбменДаннымиМобильноеПриложениеМаркировкаИСМПТК.Сериализовать(Список);
	
КонецФункции

Функция GiveAllTAC(StartDate, EndDate)
	
	Запрос = Новый Запрос;
	Запрос.Текст = 
	"ВЫБРАТЬ
	|	АктПриемаПередачиИСМПТК.Номер КАК Номер,
	|	АктПриемаПередачиИСМПТК.Дата КАК Дата,
	|	АктПриемаПередачиИСМПТК.Состояние КАК Состояние,
	|	АктПриемаПередачиИСМПТК.ДатаВИСМПТ КАК ДатаВИСМПТ
	|ИЗ
	|	Документ.АктПриемаПередачиИСМПТК КАК АктПриемаПередачиИСМПТК
	|ГДЕ
	|	АктПриемаПередачиИСМПТК.Направление = &Направление
	|	И АктПриемаПередачиИСМПТК.ТипАкта = &ТипАкта
	|	И АктПриемаПередачиИСМПТК.Статус = &Статус
	|	И АктПриемаПередачиИСМПТК.ДатаВИСМПТ МЕЖДУ &ДатаНачала И &ДатаОкончания
	|
	|УПОРЯДОЧИТЬ ПО
	|	ДатаВИСМПТ";
	
	Запрос.УстановитьПараметр("ДатаНачала", StartDate);
	Запрос.УстановитьПараметр("ДатаОкончания", EndDate);
	Запрос.УстановитьПараметр("Направление", Перечисления.НаправленияДокументовИСМПТК.Входящий);
	Запрос.УстановитьПараметр("ТипАкта", Перечисления.ВидыДокументаИСМПТК.Исходный);
	Запрос.УстановитьПараметр("Статус", Перечисления.СтатусыДокументовИСМПТК.ОжидаетПриемку);
	
	Выборка = Запрос.Выполнить().Выбрать();
	
	ТЗ = Новый ТаблицаЗначений;
	ТипСтрока = Новый ОписаниеТипов("Строка");
	
	ТЗ.Колонки.Добавить("Документ", ТипСтрока);
	ТЗ.Колонки.Добавить("Номер",    ТипСтрока);
	
	Пока Выборка.Следующий() Цикл
		Строка = ТЗ.Добавить();
		Строка.Документ = Выборка.Номер + " ( " + Выборка.ДатаВИСМПТ + "): " + Выборка.Состояние;
		Строка.Номер = Выборка.Номер;
	КонецЦикла;
	
	Возврат ОбменДаннымиМобильноеПриложениеМаркировкаИСМПТК.Сериализовать(ТЗ);
	
КонецФункции

Функция GiveTACCodes(Document)
	
	НомерДокумента = ОбменДаннымиМобильноеПриложениеМаркировкаИСМПТК.Десериализовать(Document);
	Запрос = Новый Запрос;
	Запрос.Текст = 
	"ВЫБРАТЬ
	|	АктПриемаПередачиИСМПТКМарки.КодИдентификации КАК КодИдентификации
	|ИЗ
	|	Документ.АктПриемаПередачиИСМПТК.Марки КАК АктПриемаПередачиИСМПТКМарки
	|ГДЕ
	|	АктПриемаПередачиИСМПТКМарки.Ссылка.Номер = &Номер";
	
	Запрос.УстановитьПараметр("Номер", НомерДокумента); 
	Выборка = Запрос.Выполнить().Выбрать();
	
	Список  = Новый СписокЗначений;
	
	Пока Выборка.Следующий() Цикл
		Список.Добавить(РазборИОбработкаКодовМаркировкиИСМПТКСлужебныйКлиентСервер.ШтрихкодВBase64(Выборка.КодИдентификации));
	КонецЦикла;
	
	Возврат ОбменДаннымиМобильноеПриложениеМаркировкаИСМПТК.Сериализовать(Список);
	
КонецФункции

Функция TakeTACDiscrepancies(SerializedDataStructure)
	
	Структура = ОбменДаннымиМобильноеПриложениеМаркировкаИСМПТК.Десериализовать(SerializedDataStructure);
	Документ  = ОбменДаннымиМобильноеПриложениеМаркировкаИСМПТК.НайтиДокументАктПриемаПередачиПоНомеру(Структура.НомерДокумента);
	
	ДокументОбъект = Документ.ПолучитьОбъект();
	
	СтруктураВозвращаемая = Новый Структура("Success, Message", Истина, "");
	СтруктураВозвращаемая.Success = Истина;
	СтруктураВозвращаемая.Message = "Данные о расхождении переданы.";
	
	ДокументОбъект.Расхождения.Очистить();
	
	Если НЕ Структура.ЕстьРасхождения Тогда
		Возврат ОбменДаннымиМобильноеПриложениеМаркировкаИСМПТК.Сериализовать(СтруктураВозвращаемая);
	КонецЕсли;
	
	Для Каждого СтрокаКодаИдентификации Из Структура.ТаблицаРасхождений Цикл
		
		СтруктураКода = Новый Структура("Штрихкод, СтатусСверкиКода", СтрокаКодаИдентификации.Штрихкод,
				Перечисления.СтатусыСверкиКодаИСМПТК.Получить(СтрокаКодаИдентификации.СтатусСверкиКода));
		ДанныеПоКоду = ОбменДаннымиМобильноеПриложениеМаркировкаИСМПТК.ПолучитьКодыМаркировки(СтруктураКода);
		НоваяСтрока = ДокументОбъект.Расхождения.Добавить();
		
		ДанныеНоменклатуры = ОбменДаннымиМобильноеПриложениеМаркировкаИСМПТК.ПолучитьНоменклатуруПоШтрихкоду(ДанныеПоКоду.EAN, ДокументОбъект);
		Если ТипЗнч(ДанныеНоменклатуры) = Тип("Структура") Тогда
			Номенклатура = ДанныеНоменклатуры.Номенклатура;
		Иначе
			Номенклатура = ДанныеНоменклатуры;
		КонецЕсли;
		
		НоваяСтрока.КодИдентификации 	= ДанныеПоКоду.КодИдентификации;
		НоваяСтрока.ВидУпаковки 		= ДанныеПоКоду.ВидУпаковки;
		НоваяСтрока.GTIN 				= ДанныеПоКоду.GTIN;
		НоваяСтрока.EAN 				= ДанныеПоКоду.EAN;
		НоваяСтрока.СтатусСверкиКода 	= СтруктураКода.СтатусСверкиКода;
		НоваяСтрока.Номенклатура		= Номенклатура;
		НоваяСтрока.Количество 			= ДанныеПоКоду.Количество;
		НоваяСтрока.ВидПродукцииИС 		= ДанныеПоКоду.ВидПродукцииИС;
		
		Если Не СтруктураКода.СтатусСверкиКода = ПредопределенноеЗначение("Перечисление.СтатусыСверкиКодаИСМПТК.Найден") Тогда
			ВсеКодыНайдены = Ложь;
		КонецЕсли;
		
	КонецЦикла;
	
	ДокументОбъект.Проверен = Истина;
	ДокументОбъект.Записать(РежимЗаписиДокумента.Запись);
	
	Возврат ОбменДаннымиМобильноеПриложениеМаркировкаИСМПТК.Сериализовать(СтруктураВозвращаемая);
	
КонецФункции
