﻿//////////////////////////////////////////////////////////
// ОБРАБОТЧИКИ СОБЫТИЙ ФОРМЫ

&НаСервере
Процедура ПриСозданииНаСервере(Отказ, СтандартнаяОбработка)
	
	УстановитьВидимостьНаСервере();
	
	ВалютаРегламентированногоУчета = ОбщегоНазначенияБКВызовСервераПовтИсп.ПолучитьВалютуРегламентированногоУчета();
	
КонецПроцедуры

&НаКлиенте
Процедура ПриЗакрытии()
	
	Оповестить("Запись_УзелПланаОбмена");
	
КонецПроцедуры // ПриЗакрытии()

&НаКлиенте
Процедура ПослеЗаписи(ПараметрыЗаписи)
	
	ОбновитьИнтерфейс();
	
КонецПроцедуры

&НаСервере
Процедура ПриЗаписиНаСервере(Отказ, ТекущийОбъект, ПараметрыЗаписи)
	
	ОбменДаннымиСервер.ФормаУзлаПриЗаписиНаСервере(ТекущийОбъект, Отказ);
	
КонецПроцедуры

//////////////////////////////////////////////////////////
// ОБРАБОТЧИКИ СОБЫТИЙ ЭЛЕМЕНТОВ ФОРМЫ

&НаКлиенте
Процедура ИспользоватьОтборПоОрганизациямПриИзменении(Элемент)
	
	УстановитьВидимостьНаСервере();
	
КонецПроцедуры // ИспользоватьОтборПоОрганизациямПриИзменении()

&НаКлиенте
Процедура КассыВРозницеОрганизацияПриИзменении(Элемент)
	
	ТекущаяСтрока = Элементы.КассыВРознице.ТекущиеДанные;
	ТекущаяСтрока.Касса = КассаПоУмолчанию(ТекущаяСтрока.Организация);
	
КонецПроцедуры

&НаКлиенте
Процедура КассыВРозницеКассаНачалоВыбора(Элемент, ДанныеВыбора, СтандартнаяОбработка)
	
	СтандартнаяОбработка = Ложь;
	ТекущаяСтрока = Элементы.КассыВРознице.ТекущиеДанные;
	Отбор = Новый Структура("Владелец", ТекущаяСтрока.Организация);
	СтруктураПараметров = Новый Структура("ВалютаДенежныхСредств, Отбор, РежимВыбора", ВалютаРегламентированногоУчета, Отбор, Истина);
	ОткрытьФорму("Справочник.Кассы.ФормаВыбора", СтруктураПараметров, Элемент);
	
КонецПроцедуры

//////////////////////////////////////////////////////////
// ПРОЧИЕ ПРОЦЕДУРЫ

&НаСервере
Процедура УстановитьВидимостьНаСервере()
	
	Элементы.Организации.Видимость  = Объект.ИспользоватьОтборПоОрганизациям;
	Элементы.ПодразделенияОрганизаций.Видимость  = Объект.ИспользоватьОтборПоПодразделениямОрганизации;
	Элементы.ИспользоватьОтборПоПодразделениямОрганизации.Видимость = Объект.ЗарплатаВыплачиваетсяИзКассыВРозничнойОптовойСети;
	
	ВестиУчетПоПодразделениям = ПроцедурыБухгалтерскогоУчетаВызовСервераПовтИсп.НаСчетеВедетсяУчетПоПодразделениям(ПланыСчетов.Типовой.ДоходОтРеализацииПродукцииИОказанияУслуг_);
	Элементы.СоответствиеПодразделенийМагазинам.Видимость = ВестиУчетПоПодразделениям;
	
КонецПроцедуры // УстановитьВидимостьНаСервере()

&НаКлиенте
Процедура ИспользоватьОтборПоПодразделениямОрганизацииПриИзменении(Элемент)
	
	УстановитьВидимостьНаСервере();
	
КонецПроцедуры // ИспользоватьОтборПоПодразделениямОрганизацииПриИзменении()

&НаКлиенте
Процедура ЗарплатаВыплачиваетсяИзКассыВРозничнойОптовойСетиПриИзменении(Элемент)
	
	Если Объект.ЗарплатаВыплачиваетсяИзКассыВРозничнойОптовойСети = Ложь Тогда
		Объект.ИспользоватьОтборПоПодразделениямОрганизации = Ложь;
	КонецЕсли;
	УстановитьВидимостьНаСервере();
	
КонецПроцедуры // ЗарплатаВыплачиваетсяИзКассыВРозничнойОптовойСетиПриИзменении()

&НаКлиенте
Процедура ПередЗаписью(Отказ, ПараметрыЗаписи)
	
	СтрокаОшибки = "";
	Если Объект.ИспользоватьОтборПоПодразделениямОрганизации И Объект.ПодразделенияОрганизаций.Количество() > 0 Тогда
		ПустыеПодразделенияМассив = Объект.ПодразделенияОрганизаций.НайтиСтроки(Новый Структура("ПодразделениеОрганизации", ПредопределенноеЗначение("Справочник.ПодразделенияОрганизаций.ПустаяСсылка")));
		Если ПустыеПодразделенияМассив.Количество() > 0 Тогда
			Отказ = Истина;
			СтрокаОшибки = "Не заполнено подразделение организации.";
		Иначе
			Для каждого ОрганизацияСтрока Из Объект.ПодразделенияОрганизаций Цикл
				Если (Объект.ИспользоватьОтборПоОрганизациям И Объект.Организации.Количество() > 0) Тогда
					НайденныеСтрокиОрганизации = Объект.Организации.НайтиСтроки(Новый Структура("Организация", ПолучитьРеквизитНаСервере(ОрганизацияСтрока.ПодразделениеОрганизации, "Владелец")));
					Если НайденныеСтрокиОрганизации.Количество() = 0 Тогда
						Отказ = Истина;
						СтрокаОшибки = "Организации отбора не соответствуют организациям подразделений организаций.";
					КонецЕсли;
				КонецЕсли;
			КонецЦикла;
		КонецЕсли;
	КонецЕсли;
	Если Отказ Тогда
		Сообщить(СтрокаОшибки);
		возврат;
	КонецЕсли;
	
КонецПроцедуры // ПередЗаписью()

&НаСервереБезКонтекста
Функция ПолучитьРеквизитНаСервере(ОбъектДляЧтения, ИмяРеквизита) Экспорт
	МетаданныеОбъекта = ОбъектДляЧтения.Метаданные();
	Если (МетаданныеОбъекта.Реквизиты.Найти(ИмяРеквизита) <> Неопределено) Или (ВРег(ИмяРеквизита)="ВЛАДЕЛЕЦ") Тогда 
		Возврат ОбъектДляЧтения[ИмяРеквизита];
	Иначе
		Возврат Неопределено;
	КонецЕсли;
КонецФункции

&НаСервере
Функция  КассаПоУмолчанию(Организация)
	
	Касса = ОбщегоНазначения.ЗначениеРеквизитаОбъекта(Организация, "ОсновнаяКасса");
	
	Если Не Касса.ВалютаДенежныхСредств = ВалютаРегламентированногоУчета Тогда
		Касса = Справочники.Кассы.ПустаяСсылка();
	КонецЕсли;
	
	Возврат Касса;

КонецФункции
