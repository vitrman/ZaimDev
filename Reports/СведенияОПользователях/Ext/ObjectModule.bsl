﻿///////////////////////////////////////////////////////////////////////////////////////////////////////
// Copyright (c) 2022, ООО 1С-Софт
// Все права защищены. Эта программа и сопроводительные материалы предоставляются 
// в соответствии с условиями лицензии Attribution 4.0 International (CC BY 4.0)
// Текст лицензии доступен по ссылке:
// https://creativecommons.org/licenses/by/4.0/legalcode
///////////////////////////////////////////////////////////////////////////////////////////////////////

#Если Сервер Или ТолстыйКлиентОбычноеПриложение Или ВнешнееСоединение Тогда

#Область ОбработчикиСобытий

Процедура ПриКомпоновкеРезультата(ДокументРезультат, ДанныеРасшифровки, СтандартнаяОбработка)
	
	СтандартнаяОбработка = Ложь;
	
	ДокументРезультат.Очистить();
	
	КомпоновщикМакета = Новый КомпоновщикМакетаКомпоновкиДанных;
	Настройки = КомпоновщикНастроек.ПолучитьНастройки();
	
	ИдентификаторыНесуществующихПользователейИБ = Новый Массив;
	
	ВнешниеНаборыДанных = Новый Структура;
	ВнешниеНаборыДанных.Вставить("ПользователиИБ", ПользователиИБ(ИдентификаторыНесуществующихПользователейИБ));
	ВнешниеНаборыДанных.Вставить("КонтактнаяИнформация", КонтактнаяИнформация(Настройки));
	
	Настройки.ПараметрыДанных.УстановитьЗначениеПараметра(
		"ИдентификаторыНесуществующихПользователейИБ", ИдентификаторыНесуществующихПользователейИБ);
	
	МакетКомпоновки = КомпоновщикМакета.Выполнить(СхемаКомпоновкиДанных, Настройки, ДанныеРасшифровки);
	
	ПроцессорКомпоновки = Новый ПроцессорКомпоновкиДанных;
	ПроцессорКомпоновки.Инициализировать(МакетКомпоновки, ВнешниеНаборыДанных, ДанныеРасшифровки, Истина);
	
	ПроцессорВывода = Новый ПроцессорВыводаРезультатаКомпоновкиДанныхВТабличныйДокумент;
	ПроцессорВывода.УстановитьДокумент(ДокументРезультат);
	
	ПроцессорВывода.НачатьВывод();
	ЭлементРезультата = ПроцессорКомпоновки.Следующий();
	Пока ЭлементРезультата <> Неопределено Цикл
		ПроцессорВывода.ВывестиЭлемент(ЭлементРезультата);
		ЭлементРезультата = ПроцессорКомпоновки.Следующий();
	КонецЦикла;
	ПроцессорВывода.ЗакончитьВывод();
	
КонецПроцедуры

#КонецОбласти

#Область СлужебныеПроцедурыИФункции

Функция ПользователиИБ(ИдентификаторыНесуществующихПользователейИБ)
	
	ПустойУникальныйИдентификатор = ОбщегоНазначенияКлиентСервер.ПустойУникальныйИдентификатор();
	ИдентификаторыНесуществующихПользователейИБ.Добавить(ПустойУникальныйИдентификатор);
	
	Запрос = Новый Запрос;
	Запрос.УстановитьПараметр("ПустойУникальныйИдентификатор", ПустойУникальныйИдентификатор);
	Запрос.Текст =
	"ВЫБРАТЬ
	|	Пользователи.ИдентификаторПользователяИБ,
	|	Пользователи.СвойстваПользователяИБ
	|ИЗ
	|	Справочник.Пользователи КАК Пользователи
	|ГДЕ
	|	Пользователи.ИдентификаторПользователяИБ <> &ПустойУникальныйИдентификатор
	|
	|ОБЪЕДИНИТЬ ВСЕ
	|
	|ВЫБРАТЬ
	|	ВнешниеПользователи.ИдентификаторПользователяИБ,
	|	ВнешниеПользователи.СвойстваПользователяИБ
	|ИЗ
	|	Справочник.ВнешниеПользователи КАК ВнешниеПользователи
	|ГДЕ
	|	ВнешниеПользователи.ИдентификаторПользователяИБ <> &ПустойУникальныйИдентификатор";
	
	Выгрузка = Запрос.Выполнить().Выгрузить();
	Выгрузка.Индексы.Добавить("ИдентификаторПользователяИБ");
	Выгрузка.Колонки.Добавить("Сопоставлен", Новый ОписаниеТипов("Булево"));
	
	ПользователиИБ = Новый ТаблицаЗначений;
	ПользователиИБ.Колонки.Добавить("УникальныйИдентификатор", Новый ОписаниеТипов("УникальныйИдентификатор"));
	ПользователиИБ.Колонки.Добавить("Имя", Новый ОписаниеТипов("Строка", , Новый КвалификаторыСтроки(100)));
	ПользователиИБ.Колонки.Добавить("ВходВПрограммуРазрешен",    Новый ОписаниеТипов("Булево"));
	ПользователиИБ.Колонки.Добавить("АутентификацияСтандартная", Новый ОписаниеТипов("Булево"));
	ПользователиИБ.Колонки.Добавить("ПоказыватьВСпискеВыбора",   Новый ОписаниеТипов("Булево"));
	ПользователиИБ.Колонки.Добавить("ЗапрещеноИзменятьПароль",   Новый ОписаниеТипов("Булево"));
	ПользователиИБ.Колонки.Добавить("АутентификацияOpenID",      Новый ОписаниеТипов("Булево"));
	ПользователиИБ.Колонки.Добавить("АутентификацияОС",          Новый ОписаниеТипов("Булево"));
	ПользователиИБ.Колонки.Добавить("ПользовательОС", Новый ОписаниеТипов("Строка", , Новый КвалификаторыСтроки(1024)));
	ПользователиИБ.Колонки.Добавить("Язык",           Новый ОписаниеТипов("Строка", , Новый КвалификаторыСтроки(100)));
	ПользователиИБ.Колонки.Добавить("РежимЗапуска",   Новый ОписаниеТипов("Строка", , Новый КвалификаторыСтроки(100)));
	
	УстановитьПривилегированныйРежим(Истина);
	ВсеПользователиИБ = ПользователиИнформационнойБазы.ПолучитьПользователей();
	
	Для каждого ПользовательИБ Из ВсеПользователиИБ Цикл
		
		СвойстваПользовательИБ = Пользователи.СвойстваПользователяИБ(ПользовательИБ.УникальныйИдентификатор);
		
		НоваяСтрока = ПользователиИБ.Добавить();
		ЗаполнитьЗначенияСвойств(НоваяСтрока, СвойстваПользовательИБ);
		Язык = СвойстваПользовательИБ.Язык;
		НоваяСтрока.Язык = ?(ЗначениеЗаполнено(Язык), Метаданные.Языки[Язык].Синоним, "");
		НоваяСтрока.ВходВПрограммуРазрешен = Пользователи.ВходВПрограммуРазрешен(СвойстваПользовательИБ);
		
		Строка = Выгрузка.Найти(СвойстваПользовательИБ.УникальныйИдентификатор, "ИдентификаторПользователяИБ");
		Если Строка <> Неопределено Тогда
			Строка.Сопоставлен = Истина;
			Если Не НоваяСтрока.ВходВПрограммуРазрешен Тогда
				ЗаполнитьЗначенияСвойств(НоваяСтрока,
					ПользователиСлужебный.ХранимыеСвойстваПользователяИБ(Строка));
			КонецЕсли;
		КонецЕсли;
	КонецЦикла;
	
	Отбор = Новый Структура("Сопоставлен", Ложь);
	Строки = Выгрузка.НайтиСтроки(Отбор);
	Для каждого Строка Из Строки Цикл
		ИдентификаторыНесуществующихПользователейИБ.Добавить(Строка.ИдентификаторПользователяИБ);
	КонецЦикла;
	
	Возврат ПользователиИБ;
	
КонецФункции

Функция КонтактнаяИнформация(Настройки)
	
	ТипыСсылки = Новый Массив;
	ТипыСсылки.Добавить(Тип("СправочникСсылка.Пользователи"));
	ТипыСсылки.Добавить(Тип("СправочникСсылка.ВнешниеПользователи"));
	
	Контакты = Новый ТаблицаЗначений;
	Контакты.Колонки.Добавить("Ссылка", Новый ОписаниеТипов(ТипыСсылки));
	Контакты.Колонки.Добавить("Телефон", Новый ОписаниеТипов("Строка"));
	Контакты.Колонки.Добавить("ЭлектронныйАдрес", Новый ОписаниеТипов("Строка"));
	
	Если Не ОбщегоНазначения.ПодсистемаСуществует("СтандартныеПодсистемы.КонтактнаяИнформация") Тогда
		Возврат Контакты;
	КонецЕсли;
	
	// БК3. В БК3 используется собственная подсистема контактной информации.
	// Код, расположенный ниже, был удален, т.к. приводил к ошибкам при расширенной проверке.
	
КонецФункции

#КонецОбласти

#Иначе
ВызватьИсключение НСтр("ru = 'Недопустимый вызов объекта на клиенте.'");
#КонецЕсли