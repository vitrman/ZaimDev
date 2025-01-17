﻿
&НаКлиенте
Перем ПараметрыОбработчикаОжидания;

&НаКлиенте
Перем УИДЗамера;

////////////////////////////////////////////////////////////////////////////////
// ОБРАБОТЧИКИ СОБЫТИЙ ФОРМЫ

&НаСервере
Процедура ПриСозданииНаСервере(Отказ, СтандартнаяОбработка)
	
	БухгалтерскиеОтчетыВызовСервера.ПриСозданииНаСервере(ЭтаФорма, Отказ, СтандартнаяОбработка);
	
	Отчет.СписокВидовСубконто.ТипЗначения = Новый ОписаниеТипов("ПланВидовХарактеристикСсылка.ВидыСубконтоТиповые");
	
	Если НЕ Отчет.РежимРасшифровки Тогда
		ЕстьКоличество = Ложь;
		ЕстьСчета      = Истина;
		ЗаполняемыеНастройки = Новый Структура("Показатели", Истина);
		ЗаполнитьНастройкамиПоУмолчанию(ЗаполняемыеНастройки);
		ЕстьКоличество = Истина;
	КонецЕсли;
	
КонецПроцедуры

&НаКлиенте
Процедура ПриОткрытии(Отказ)
	
	ОбновитьТекстЗаголовка(ЭтаФорма);
		
	ИБФайловая = СтандартныеПодсистемыКлиентПовтИсп.ПараметрыРаботыКлиента().ИнформационнаяБазаФайловая;
	ПодключитьОбработчикОжидания = Не ИБФайловая И ЗначениеЗаполнено(ИдентификаторЗадания);
	Если ПодключитьОбработчикОжидания Тогда		
		ДлительныеОперацииКлиент.ИнициализироватьПараметрыОбработчикаОжидания(ПараметрыОбработчикаОжидания);
		ПодключитьОбработчикОжидания("Подключаемый_ПроверитьВыполнениеЗадания", 1, Истина);
		ОбщегоНазначенияКлиентСервер.УстановитьСостояниеПоляТабличногоДокумента(Элементы.Результат, "ФормированиеОтчета");
	КонецЕсли;
	
	БухгалтерскиеОтчетыКлиент.ПриОткрытии(ЭтаФорма, Отказ);
	
	Отчет.ПредставлениеСпискаОрганизаций = БухгалтерскиеОтчетыКлиентСервер.ВыгрузитьСписокВСтроку(СписокСтруктурныхЕдиниц);
	
	Для Каждого ЭлементСписка Из СписокПодразделений Цикл
		Если ЭлементСписка.Значение = ПредопределенноеЗначение("Справочник.ПодразделенияОрганизаций.ПустаяСсылка") Тогда 
			ЭлементСписка.Представление = "Головное подразделение";
		КонецЕсли;				
	КонецЦикла;
	
	Отчет.ПредставлениеСпискаПодразделений = БухгалтерскиеОтчетыКлиентСервер.ВыгрузитьСписокВСтроку(СписокПодразделений);
	
	УправлениеФормой(ЭтаФорма);
	
КонецПроцедуры

&НаКлиенте
Процедура ПередЗакрытием(Отказ, ЗавершениеРаботы, ТекстПредупреждения, СтандартнаяОбработка)
	
	БухгалтерскиеОтчетыКлиент.ПередЗакрытием(ЭтаФорма, Отказ, ЗавершениеРаботы, ТекстПредупреждения, СтандартнаяОбработка);
	
КонецПроцедуры

&НаКлиенте
Процедура ПриЗакрытии(ЗавершениеРаботы)
	
	Если ЗавершениеРаботы Тогда
		Возврат;	
	КонецЕсли;
	
	Если ЗначениеЗаполнено(ИдентификаторЗадания) Тогда
		ОтменитьВыполнениеЗадания();
	КонецЕсли;
	
КонецПроцедуры

&НаСервере
Процедура ПриСохраненииПользовательскихНастроекНаСервере(Настройки)
	
	БухгалтерскиеОтчетыВызовСервера.ПриСохраненииПользовательскихНастроекНаСервере(ЭтаФорма, Настройки);
	
КонецПроцедуры

&НаСервере
Процедура ПриЗагрузкеПользовательскихНастроекНаСервере(Настройки)
	
	БухгалтерскиеОтчетыВызовСервера.ПриЗагрузкеПользовательскихНастроекНаСервере(ЭтаФорма, Настройки);
	
	ИзменениеСхемыКомпоновкиДанныхНаСервере();
	
	ЗаполнитьПризнакиУчета();
	
	ОбновитьТекстЗаголовка(ЭтаФорма);
	
	УправлениеФормой(ЭтаФорма);
	
	Если Не ЗначениеЗаполнено(ИдентификаторЗадания) Тогда
		ОбщегоНазначенияКлиентСервер.УстановитьСостояниеПоляТабличногоДокумента(Элементы.Результат, "НеАктуальность");
	КонецЕсли;
	
КонецПроцедуры

&НаКлиенте
Процедура ОбработкаВыбора(ВыбранноеЗначение, ИсточникВыбора)
	
	БухгалтерскиеОтчетыКлиент.ОтправитьОтчетыПоПочтеОбработкаВыбора(ВыбранноеЗначение, ИсточникВыбора, ЭтотОбъект);
	
КонецПроцедуры


////////////////////////////////////////////////////////////////////////////////
// ОБРАБОТЧИКИ СОБЫТИЙ ЭЛЕМЕНТОВ ШАПКИ ФОРМЫ

&НаКлиенте
Процедура НачалоПериодаПриИзменении(Элемент)
	
	ОбновитьТекстЗаголовка(ЭтаФорма);
	Если Не ЗначениеЗаполнено(ИдентификаторЗадания) Тогда
		ОбщегоНазначенияКлиентСервер.УстановитьСостояниеПоляТабличногоДокумента(Элементы.Результат, "НеАктуальность");
	КонецЕсли;
	
КонецПроцедуры

&НаКлиенте
Процедура КонецПериодаПриИзменении(Элемент)
	
	ОбновитьТекстЗаголовка(ЭтаФорма);
	Если Не ЗначениеЗаполнено(ИдентификаторЗадания) Тогда
		ОбщегоНазначенияКлиентСервер.УстановитьСостояниеПоляТабличногоДокумента(Элементы.Результат, "НеАктуальность");
	КонецЕсли;
	
КонецПроцедуры

&НаКлиенте
Процедура ПредставлениеСпискаОрганизацийНачалоВыбора(Элемент, ДанныеВыбора, СтандартнаяОбработка)
	
	ДополнительныеПараметры = Новый Структура;
	ДополнительныеПараметры.Вставить("СписокСтруктурныхЕдиниц"              , СписокСтруктурныхЕдиниц);
	ДополнительныеПараметры.Вставить("СписокПодразделений"                  , СписокПодразделений);
	ДополнительныеПараметры.Вставить("СписокВладельцевГоловныхПодразделений", СписокВладельцевГоловныхПодразделений);
	ДополнительныеПараметры.Вставить("ВыборСтруктурныхПодразделений"        , ПоддержкаРаботыСоСтруктурнымиПодразделениями); 
	
	БухгалтерскиеОтчетыКлиент.ПредставлениеСпискаОрганизацийНачалоВыбора(ЭтаФорма, СтандартнаяОбработка, ДополнительныеПараметры);
	
КонецПроцедуры

&НаКлиенте
Процедура ПредставлениеСпискаОрганизацийОчистка(Элемент, СтандартнаяОбработка)
	
	СписокПодразделений.Очистить();
	СписокСтруктурныхЕдиниц.Очистить();
	СписокВладельцевГоловныхПодразделений.Очистить();
	
	Отчет.ПредставлениеСпискаОрганизаций   = "";
	Отчет.ПредставлениеСпискаПодразделений = "";
	
	УправлениеФормой(ЭтаФорма);
	
КонецПроцедуры

&НаКлиенте
Процедура ПоказательПриИзменении(Элемент)
	
	Если НЕ (Отчет.ПоказательБУ ИЛИ Отчет.ПоказательКоличество
		     ИЛИ Отчет.ПоказательНУ ИЛИ Отчет.ПоказательКоличествоНУ
			 ИЛИ Отчет.ПоказательПР ИЛИ Отчет.ПоказательКоличествоПР
			 ИЛИ Отчет.ПоказательВР) Тогда
		Отчет[Элемент.Имя] = Истина;
	КонецЕсли;
	
	Если Не ЗначениеЗаполнено(ИдентификаторЗадания) Тогда
		ОбщегоНазначенияКлиентСервер.УстановитьСостояниеПоляТабличногоДокумента(Элементы.Результат, "НеАктуальность");
	КонецЕсли;
	
КонецПроцедуры

&НаКлиенте
Процедура МакетОформленияПриИзменении(Элемент)
	
	БухгалтерскиеОтчетыКлиентСервер.УстановитьПараметрВывода(Отчет.КомпоновщикНастроек.Настройки, "МакетОформления", МакетОформления);
	
	Если Не ЗначениеЗаполнено(ИдентификаторЗадания) Тогда
		ОбщегоНазначенияКлиентСервер.УстановитьСостояниеПоляТабличногоДокумента(Элементы.Результат, "НеАктуальность");
	КонецЕсли;
	
КонецПроцедуры

&НаКлиенте
Процедура ВыводитьЗаголовокПриИзменении(Элемент)

	Если Не ЗначениеЗаполнено(ИдентификаторЗадания) Тогда
		ОбщегоНазначенияКлиентСервер.УстановитьСостояниеПоляТабличногоДокумента(Элементы.Результат, "НеАктуальность");
	КонецЕсли;

КонецПроцедуры

&НаКлиенте
Процедура ВыводитьПодписиПриИзменении(Элемент)
	
	ВыводитьПодписиРуководителей = Ложь;
	УправлениеФормой(ЭтаФорма);

	Если Не ЗначениеЗаполнено(ИдентификаторЗадания) Тогда
		ОбщегоНазначенияКлиентСервер.УстановитьСостояниеПоляТабличногоДокумента(Элементы.Результат, "НеАктуальность");
	КонецЕсли;

КонецПроцедуры

&НаКлиенте
Процедура ВыводитьПодписиРуководителейПриИзменении(Элемент)

	Если Не ЗначениеЗаполнено(ИдентификаторЗадания) Тогда
		ОбщегоНазначенияКлиентСервер.УстановитьСостояниеПоляТабличногоДокумента(Элементы.Результат, "НеАктуальность");
	КонецЕсли;

КонецПроцедуры


////////////////////////////////////////////////////////////////////////////////
// ПРОЦЕДУРЫ - ОБРАБОТЧИКИ СОБЫТИЙ ПОЛЯ ТАБЛИЧНОГО ДОКУМЕНТА

&НаКлиенте
Процедура РезультатПриАктивизацииОбласти(Элемент)
	
	Если ТипЗнч(Результат.ВыделенныеОбласти) = Тип("ВыделенныеОбластиТабличногоДокумента") Тогда
		ИнтервалОжидания = ?(ПолучитьСкоростьКлиентскогоСоединения() = СкоростьКлиентскогоСоединения.Низкая, 1, 0.2);
		ПодключитьОбработчикОжидания("Подключаемый_РезультатПриАктивизацииОбластиПодключаемый", ИнтервалОжидания, Истина);
	КонецЕсли;
	
КонецПроцедуры

&НаКлиенте
Процедура РезультатОбработкаРасшифровки(Элемент, Расшифровка, СтандартнаяОбработка)
	
	БухгалтерскиеОтчетыКлиент.ОбработкаРасшифровкиСтандартногоОтчета(ЭтаФорма, Элемент, Расшифровка, СтандартнаяОбработка);
	
КонецПроцедуры

&НаКлиенте
Процедура РезультатОбработкаДополнительнойРасшифровки(Элемент, Расшифровка, СтандартнаяОбработка)
	
	// Не будем обрабатывать нажатие на правую кнопку мыши.
	// Покажем стандартное контекстное меню ячейки табличного документа.
	Расшифровка = Неопределено;
	
КонецПроцедуры


////////////////////////////////////////////////////////////////////////////////
// ОБРАБОТЧИКИ СОБЫТИЙ ТАБЛИЦЫ ФОРМЫ ВИДЫ СУБКОНТО

&НаКлиенте
Процедура СписокВидовСубконтоПриИзменении(Элемент)
	
	СписокВидовСубконтоПриИзмененииСервер();
	
	ОбновитьТекстЗаголовка(ЭтаФорма); 
	
	Если Не ЗначениеЗаполнено(ИдентификаторЗадания) Тогда
		ОбщегоНазначенияКлиентСервер.УстановитьСостояниеПоляТабличногоДокумента(Элементы.Результат, "НеАктуальность");
	КонецЕсли;
	
КонецПроцедуры	

&НаКлиенте
Процедура ПериодичностьПриИзменении(Элемент)

	Если Не ЗначениеЗаполнено(ИдентификаторЗадания) Тогда
		ОбщегоНазначенияКлиентСервер.УстановитьСостояниеПоляТабличногоДокумента(Элементы.Результат, "НеАктуальность");
	КонецЕсли;

КонецПроцедуры


////////////////////////////////////////////////////////////////////////////////
// ОБРАБОТЧИКИ СОБЫТИЙ ТАБЛИЦЫ ФОРМЫ ОТБОРЫ

&НаКлиенте
Процедура ОтборыПриИзменении(Элемент)
	
	БухгалтерскиеОтчетыКлиент.ОтборыПриИзменении(ЭтаФорма, Элемент, Ложь);
	
	ОбновитьТекстЗаголовка(ЭтаФорма);
	
КонецПроцедуры

&НаКлиенте
Процедура ОтборыПередНачаломДобавления(Элемент, Отказ, Копирование, Родитель, Группа)
	
	БухгалтерскиеОтчетыКлиент.ОтборыПередНачаломДобавления(ЭтаФорма, Элемент, Отказ, Копирование, Родитель, Группа);

КонецПроцедуры

&НаКлиенте
Процедура ОтборыПередНачаломИзменения(Элемент, Отказ)
	
	БухгалтерскиеОтчетыКлиент.ОтборыПередНачаломИзменения(ЭтаФорма, Элемент, Отказ);	
	
КонецПроцедуры

&НаКлиенте
Процедура ОтборыПравоеЗначениеНачалоВыбора(Элемент, ДанныеВыбора, СтандартнаяОбработка)
	
	СписокПараметров = ПолучитьПараметрыВыбораЗначенияОтбора();
	БухгалтерскиеОтчетыКлиент.ОтборыПравоеЗначениеНачалоВыбора(ЭтаФорма, Элемент, ДанныеВыбора, СтандартнаяОбработка, СписокПараметров);
	
КонецПроцедуры


////////////////////////////////////////////////////////////////////////////////
// ОБРАБОТЧИКИ КОМАНД ФОРМЫ

&НаКлиенте
Процедура ВыбратьПериод(Команда)
	
	ПараметрыВыбора = Новый Структура("НачалоПериода,КонецПериода", Отчет.НачалоПериода, Отчет.КонецПериода);
	ОписаниеОповещения = Новый ОписаниеОповещения("ВыбратьПериодЗавершение", ЭтотОбъект);
	ОткрытьФорму("ОбщаяФорма.ВыборСтандартногоПериода", ПараметрыВыбора, Элементы.ВыбратьПериод, , , , ОписаниеОповещения);

КонецПроцедуры

&НаКлиенте
Процедура ЗакрытьНастройки(Команда)
	
	Элементы.Сформировать.КнопкаПоУмолчанию = Истина;
	ПодключитьОбработчикОжидания("Подключаемый_ЗакрытьНастройки", 0.1, Истина);
	
КонецПроцедуры

&НаКлиенте
Процедура ПоказатьНастройки(Команда)
	
	Элементы.ПрименитьНастройки.КнопкаПоУмолчанию = Истина;
	Элементы.РазделыОтчета.ТекущаяСтраница = Элементы.НастройкиОтчета;
	
КонецПроцедуры

&НаКлиенте
Процедура СформироватьОтчет(Команда)
	
	ОчиститьСообщения();
	
	ОтключитьОбработчикОжидания("Подключаемый_ПроверитьВыполнениеЗадания");
	
	УИДЗамера = ОценкаПроизводительностиКлиент.НачатьЗамерВремени(Ложь, "Отчет ""карточка субконто (налоговый)"" (формирование)"); 

	РезультатВыполнения = СформироватьОтчетНаСервере();
	Если Не РезультатВыполнения.ЗаданиеВыполнено Тогда
		ДлительныеОперацииКлиент.ИнициализироватьПараметрыОбработчикаОжидания(ПараметрыОбработчикаОжидания);
		ПодключитьОбработчикОжидания("Подключаемый_ПроверитьВыполнениеЗадания", 1, Истина);
		ОбщегоНазначенияКлиентСервер.УстановитьСостояниеПоляТабличногоДокумента(Элементы.Результат, "ФормированиеОтчета");
	Иначе
		ЗафиксироватьДлительностьКлючевойОперации();
	КонецЕсли;
	
	ПодключитьОбработчикОжидания("Подключаемый_ЗакрытьНастройки", 0.1, Истина);
	
КонецПроцедуры

&НаКлиенте
Процедура ОтправитьПоЭлектроннойПочте(Команда)

	ПоказатьДиалогОтправкиПоЭлектроннойПочте();
	
КонецПроцедуры


////////////////////////////////////////////////////////////////////////////////
// СЛУЖЕБНЫЕ ПРОЦЕДУРЫ И ФУНКЦИИ

&НаКлиенте
Процедура ВыбратьПериодЗавершение(РезультатВыбора, ДопПараметры) Экспорт
	
	Если РезультатВыбора = Неопределено Тогда
		Возврат;
	КонецЕсли;
	ЗаполнитьЗначенияСвойств(Отчет, РезультатВыбора, "НачалоПериода,КонецПериода");
	
	ОбновитьТекстЗаголовка(ЭтаФорма); 
	Если Не ЗначениеЗаполнено(ИдентификаторЗадания) Тогда
		ОбщегоНазначенияКлиентСервер.УстановитьСостояниеПоляТабличногоДокумента(Элементы.Результат, "НеАктуальность");
	КонецЕсли;

КонецПроцедуры

&НаКлиентеНаСервереБезКонтекста
Процедура УправлениеФормой(Форма)
	
	Элементы = Форма.Элементы;
	
	Элементы.ПоказательБУ.Доступность            = Форма.ЕстьСчета;
	Элементы.ПоказательКоличество.Доступность    = Форма.ЕстьКоличество;
	Элементы.ПоказательНУ.Доступность            = Форма.ЕстьСчета;
	Элементы.ПоказательКоличествоНУ.Доступность  = Форма.ЕстьКоличество;
	Элементы.ПоказательПР.Доступность            = Форма.ЕстьСчета;
	Элементы.ПоказательКоличествоПР.Доступность  = Форма.ЕстьКоличество;
	Элементы.ПоказательВР.Доступность            = Форма.ЕстьСчета;
	
	Элементы.ВыводитьПодписиРуководителей.Доступность = Форма.ВыводитьПодписи;
	
	Элементы.ПредставлениеСпискаПодразделений.Видимость = Форма.СписокПодразделений.Количество() > 0;
	
КонецПроцедуры

&НаСервере
Процедура ИзменениеСхемыКомпоновкиДанныхНаСервере() Экспорт
	
	Схема = ПолучитьИзВременногоХранилища(СхемаКомпоновкиДанных);
		
	ИмяПоляПрефикс = "Субконто";
	
	// Изменение представления и наложения ограничения типа значения
	Индекс = 1;
	Для Каждого ВидСубконто Из Отчет.СписокВидовСубконто Цикл
		Если ЗначениеЗаполнено(ВидСубконто.Значение) Тогда
			Поле = Схема.НаборыДанных.Проводки.Поля.Найти(ИмяПоляПрефикс + Индекс);
			Если Поле <> Неопределено Тогда
				Поле.ТипЗначения = ВидСубконто.Значение.ТипЗначения;
				Поле.Заголовок   = Строка(ВидСубконто.Значение);
			КонецЕсли;
			Индекс = Индекс + 1;
		КонецЕсли;
	КонецЦикла;
	
	СхемаКомпоновкиДанных = ПоместитьВоВременноеХранилище(Схема, СхемаКомпоновкиДанных);
	Отчет.КомпоновщикНастроек.Инициализировать(Новый ИсточникДоступныхНастроекКомпоновкиДанных(СхемаКомпоновкиДанных));
		
КонецПроцедуры

&НаКлиентеНаСервереБезКонтекста
Процедура ОбновитьТекстЗаголовка(Форма)
	
	Отчет = Форма.Отчет;

	ТекстСубконто = "";
	Для Каждого ВидСубконто Из Отчет.СписокВидовСубконто Цикл
		Если ЗначениеЗаполнено(ВидСубконто.Значение) Тогда
			ТекстСубконто = ТекстСубконто + ВидСубконто + ", ";
		КонецЕсли;
	КонецЦикла;
	Если Не ПустаяСтрока(ТекстСубконто) Тогда
		ТекстСубконто = Лев(ТекстСубконто, СтрДлина(ТекстСубконто) - 2);
	КонецЕсли;
	
	ЗаголовокОтчета = НСтр("ru = 'Карточка субконто (налоговый учет) %1 %2'");
	ЗаголовокОтчета = СтроковыеФункцииКлиентСервер.ПодставитьПараметрыВСтроку(
		ЗаголовокОтчета, ТекстСубконто, БухгалтерскиеОтчетыКлиентСервер.ПолучитьПредставлениеПериода(Отчет.НачалоПериода, Отчет.КонецПериода));
	
	Форма.Заголовок = ЗаголовокОтчета;


КонецПроцедуры

&НаСервереБезКонтекста
Функция ЗаданиеВыполнено(ИдентификаторЗадания)
	
	Возврат ДлительныеОперации.ЗаданиеВыполнено(ИдентификаторЗадания);
	
КонецФункции

&НаСервере
Процедура ОтменитьВыполнениеЗадания()
	
	ДлительныеОперации.ОтменитьВыполнениеЗадания(ИдентификаторЗадания);
	
КонецПроцедуры

&НаСервере
Процедура ВычислитьСуммуВыделенныхЯчеекТабличногоДокументаВКонтекстеНаСервере()
	
	ПолеСумма = БухгалтерскиеОтчетыВызовСервера.ВычислитьСуммуВыделенныхЯчеекТабличногоДокумента(
		Результат, КэшВыделеннойОбласти);
	
КонецПроцедуры

&НаСервере
Процедура ЗаполнитьНастройкамиПоУмолчанию(ЗаполняемыеНастройки) Экспорт
	
	МассивСубконто = Новый Массив;
	Для Каждого ЭлементСписка Из Отчет.СписокВидовСубконто Цикл 
		Если ЗначениеЗаполнено(ЭлементСписка.Значение) Тогда
			МассивСубконто.Добавить(ЭлементСписка.Значение);
		КонецЕсли;
	КонецЦикла;
	
	ИмяПоляПрефикс = "Субконто";
	
	Если ЗаполняемыеНастройки.Свойство("Показатели") Тогда
		Если ЗаполняемыеНастройки.Показатели Тогда
			// Управление показателями
			Отчет.ПоказательБУ           = ЕстьСчета;
			Отчет.ПоказательКоличество   = ЕстьКоличество;
			Отчет.ПоказательНУ           = Ложь;
			Отчет.ПоказательКоличествоНУ = Ложь;
			Отчет.ПоказательПР           = Ложь;
			Отчет.ПоказательКоличествоПР = Ложь;
			Отчет.ПоказательВР           = Ложь;
		КонецЕсли;
	КонецЕсли;

	Если ЗаполняемыеНастройки.Свойство("Отбор") Тогда
		Если ЗаполняемыеНастройки.Отбор И НЕ Отчет.РежимРасшифровки Тогда
			// Добавление неактивных отборов по субконто в соответствии с выбранным счетом
			ОтборыДляУдаления = Новый Массив;
			Для Каждого ЭлементОтбора Из Отчет.КомпоновщикНастроек.Настройки.Отбор.Элементы Цикл
				Если ТипЗнч(ЭлементОтбора) = Тип("ЭлементОтбораКомпоновкиДанных") Тогда 
					Если Найти(ЭлементОтбора.ЛевоеЗначение, "Субконто") > 0
						ИЛИ (Найти(ЭлементОтбора.ЛевоеЗначение, "Подразделение") = 1) Тогда
						ОтборыДляУдаления.Добавить(ЭлементОтбора);
					КонецЕсли;
				КонецЕсли;
			КонецЦикла;
			
			Для Каждого ЭлементОтбора Из ОтборыДляУдаления Цикл
				Отчет.КомпоновщикНастроек.Настройки.Отбор.Элементы.Удалить(ЭлементОтбора);
			КонецЦикла;
		
			Для Индекс = 1 По МассивСубконто.Количество() Цикл
				ПолеДляПоиска = Новый ПолеКомпоновкиДанных(ИмяПоляПрефикс + Индекс);
				Поле = Отчет.КомпоновщикНастроек.Настройки.ДоступныеПоляОтбора.НайтиПоле(ПолеДляПоиска);
				НовыйЭлементОтбора = БухгалтерскиеОтчетыКлиентСервер.ДобавитьОтбор(Отчет.КомпоновщикНастроек, ИмяПоляПрефикс + Индекс, 
										МассивСубконто[Индекс - 1].ТипЗначения.ПривестиЗначение(Неопределено),, Ложь);	
			КонецЦикла;
			
		КонецЕсли;
	КонецЕсли;
	
КонецПроцедуры

&НаСервере
Функция СформироватьОтчетНаСервере() Экспорт
	
	Если Не ПроверитьЗаполнение() Тогда
		Возврат Новый Структура("ЗаданиеВыполнено, ОтказПроверкиЗаполнения", Истина, Истина);
	КонецЕсли;
	
	ДополнительныеСвойства = Отчет.КомпоновщикНастроек.Настройки.ДополнительныеСвойства;
	
	ИБФайловая = ОбщегоНазначения.ИнформационнаяБазаФайловая();
	
	ДлительныеОперации.ОтменитьВыполнениеЗадания(ИдентификаторЗадания);
	
	ИдентификаторЗадания = Неопределено;
	
	ОбщегоНазначенияКлиентСервер.УстановитьСостояниеПоляТабличногоДокумента(Элементы.Результат, "НеИспользовать");
	
	ПараметрыОтчета = ПодготовитьПараметрыОтчета();
	ПараметрыОтчета.Вставить("ЗначенияПоказателей", ЗначенияПоказателей);
	
	Если ИБФайловая Тогда
		АдресХранилища = ПоместитьВоВременноеХранилище(Неопределено, УникальныйИдентификатор);
		БухгалтерскиеОтчетыВызовСервера.СформироватьОтчет(ПараметрыОтчета, АдресХранилища);
		РезультатВыполнения = Новый Структура("ЗаданиеВыполнено", Истина);
	Иначе
		РезультатВыполнения = ДлительныеОперации.ЗапуститьВыполнениеВФоне(
			УникальныйИдентификатор,
			"БухгалтерскиеОтчетыВызовСервера.СформироватьОтчет",
			ПараметрыОтчета,
			БухгалтерскиеОтчетыКлиентСервер.ПолучитьНаименованиеЗаданияВыполненияОтчета(ЭтаФорма));
			
		АдресХранилища       = РезультатВыполнения.АдресХранилища;
		ИдентификаторЗадания = РезультатВыполнения.ИдентификаторЗадания;
	КонецЕсли;
	
	Если РезультатВыполнения.ЗаданиеВыполнено Тогда
		ЗагрузитьПодготовленныеДанные();
	КонецЕсли;
	
	Элементы.Сформировать.КнопкаПоУмолчанию = Истина;
	
	ЗначенияПоказателей = ПараметрыОтчета.ЗначенияПоказателей;
	
	Возврат РезультатВыполнения;
	
КонецФункции

&НаСервере
Функция ПодготовитьПараметрыОтчета()
	
	ПараметрыОтчета = Новый Структура;
	ПараметрыОтчета.Вставить("НачалоПериода"                         , Отчет.НачалоПериода);
	ПараметрыОтчета.Вставить("КонецПериода"                          , Отчет.КонецПериода);
	ПараметрыОтчета.Вставить("ПоказательБУ"                          , Отчет.ПоказательБУ);
	ПараметрыОтчета.Вставить("ПоказательКоличество"                  , Отчет.ПоказательКоличество);
	ПараметрыОтчета.Вставить("ПоказательНУ"                          , Отчет.ПоказательНУ);
	ПараметрыОтчета.Вставить("ПоказательКоличествоНУ"                , Отчет.ПоказательКоличествоНУ);
	ПараметрыОтчета.Вставить("ПоказательПР"                          , Отчет.ПоказательПР);
	ПараметрыОтчета.Вставить("ПоказательКоличествоПР"                , Отчет.ПоказательКоличествоПР);
	ПараметрыОтчета.Вставить("ПоказательВР"                          , Отчет.ПоказательВР);
	ПараметрыОтчета.Вставить("Периодичность"                         , Отчет.Периодичность);
	ПараметрыОтчета.Вставить("СписокВидовСубконто"                   , Отчет.СписокВидовСубконто);
	ПараметрыОтчета.Вставить("РежимРасшифровки"                      , Отчет.РежимРасшифровки);
	ПараметрыОтчета.Вставить("СписокСтруктурныхЕдиниц"               , СписокСтруктурныхЕдиниц);
	ПараметрыОтчета.Вставить("СписокПодразделений"                   , СписокПодразделений);
	ПараметрыОтчета.Вставить("СписокВладельцевГоловныхПодразделений" , СписокВладельцевГоловныхПодразделений);
	ПараметрыОтчета.Вставить("ВыводитьЗаголовок"                     , ВыводитьЗаголовок);
	ПараметрыОтчета.Вставить("ВыводитьПодписи"                       , ВыводитьПодписи);
	ПараметрыОтчета.Вставить("ВыводитьПодписиРуководителей"          , ВыводитьПодписиРуководителей);
	ПараметрыОтчета.Вставить("ДанныеРасшифровки"                     , ДанныеРасшифровки);
	ПараметрыОтчета.Вставить("МакетОформления"                       , МакетОформления);	
	ПараметрыОтчета.Вставить("СхемаКомпоновкиДанных"                 , ПолучитьИзВременногоХранилища(СхемаКомпоновкиДанных));
	ПараметрыОтчета.Вставить("ИдентификаторОтчета"                   , БухгалтерскиеОтчетыКлиентСервер.ПолучитьИдентификаторОбъекта(ЭтаФорма));
	ПараметрыОтчета.Вставить("НастройкиКомпоновкиДанных"             , Отчет.КомпоновщикНастроек.ПолучитьНастройки());
	ПараметрыОтчета.Вставить("НаборПоказателей"                      , Отчеты[ПараметрыОтчета.ИдентификаторОтчета].ПолучитьНаборПоказателей());
	
	Возврат ПараметрыОтчета;
	
КонецФункции

&НаСервере
Процедура ЗагрузитьПодготовленныеДанные()

	РезультатВыполнения = ПолучитьИзВременногоХранилища(АдресХранилища);
	Результат           = РезультатВыполнения.Результат;
	ДанныеРасшифровки   = РезультатВыполнения.ДанныеРасшифровки;
	
	ИдентификаторЗадания = Неопределено;
	
	ОбщегоНазначенияКлиентСервер.УстановитьСостояниеПоляТабличногоДокумента(Элементы.Результат, "НеИспользовать");
	
	ДополнительныеСвойства = Отчет.КомпоновщикНастроек.Настройки.ДополнительныеСвойства;
	
КонецПроцедуры

&НаКлиенте
Процедура Подключаемый_РезультатПриАктивизацииОбластиПодключаемый()
	
	НеобходимоВычислятьНаСервере = Ложь;
	БухгалтерскиеОтчетыКлиент.ВычислитьСуммуВыделенныхЯчеекТабличногоДокумента(
		ПолеСумма, Результат, КэшВыделеннойОбласти, НеобходимоВычислятьНаСервере);
	
	Если НеобходимоВычислятьНаСервере Тогда
		ВычислитьСуммуВыделенныхЯчеекТабличногоДокументаВКонтекстеНаСервере();
	КонецЕсли;
	
	ОтключитьОбработчикОжидания("Подключаемый_РезультатПриАктивизацииОбластиПодключаемый");
	
КонецПроцедуры

&НаКлиенте
Процедура Подключаемый_ЗакрытьНастройки()
	
	Элементы.РазделыОтчета.ТекущаяСтраница = Элементы.Отчет;
	
КонецПроцедуры

&НаКлиенте
Процедура Подключаемый_ПроверитьВыполнениеЗадания()
	
	Попытка
		Если ЗаданиеВыполнено(ИдентификаторЗадания) Тогда 

			ЗагрузитьПодготовленныеДанные();
			ОбщегоНазначенияКлиентСервер.УстановитьСостояниеПоляТабличногоДокумента(Элементы.Результат, "НеИспользовать");
		    ЗафиксироватьДлительностьКлючевойОперации();
			
		Иначе
			ДлительныеОперацииКлиент.ОбновитьПараметрыОбработчикаОжидания(ПараметрыОбработчикаОжидания);
			ПодключитьОбработчикОжидания(
				"Подключаемый_ПроверитьВыполнениеЗадания", 
				ПараметрыОбработчикаОжидания.ТекущийИнтервал, 
				Истина);
		КонецЕсли;
	Исключение
		УИДЗамера = Неопределено;
		ОбщегоНазначенияКлиентСервер.УстановитьСостояниеПоляТабличногоДокумента(Элементы.Результат, "НеИспользовать");
		ВызватьИсключение;
	КонецПопытки;
	
КонецПроцедуры

&НаКлиенте
Функция ПолучитьЗапрещенныеПоля(Режим = "") Экспорт
	
	СписокПолей = Новый Массив;
	
	СписокПолей.Добавить("UserFields");
	СписокПолей.Добавить("DataParameters");
	СписокПолей.Добавить("SystemFields");
	СписокПолей.Добавить("Показатели");
	СписокПолей.Добавить("Период");
	СписокПолей.Добавить("ПериодГруппировки");
	
	Для Индекс = 1 По 3 Цикл
		СписокПолей.Добавить("ВидСубконто" + Индекс);
	КонецЦикла;
	
	КоличествоСубконто = 0;
	Для Каждого ЭлементСписка Из Отчет.СписокВидовСубконто Цикл
		Если ЗначениеЗаполнено(ЭлементСписка.Значение) Тогда
			КоличествоСубконто = КоличествоСубконто + 1;
		КонецЕсли;
	КонецЦикла;
	Для Индекс = КоличествоСубконто + 1 По 3 Цикл
		СписокПолей.Добавить("Субконто" + Индекс);
	КонецЦикла;
	
	Если Не ЕстьУчетПоПодразделениям Тогда
		СписокПолей.Добавить("Подразделение");
	КонецЕсли;
	
	Если Режим = "Отбор" Тогда
		Для Каждого ИмяПоказателя Из НаборПоказателей Цикл
			Если Не Отчет["Показатель" + ИмяПоказателя] Тогда
				СписокПолей.Добавить(ИмяПоказателя + "Дт");
				СписокПолей.Добавить(ИмяПоказателя + "Кт");
			КонецЕсли;
		КонецЦикла;
	КонецЕсли;
	
	Возврат Новый ФиксированныйМассив(СписокПолей);
	
КонецФункции

&НаКлиенте
Функция ПолучитьПараметрыВыбораЗначенияОтбора() Экспорт
	
	СписокПараметров = Новый Структура;
	СписокПараметров.Вставить("Дата"        , Отчет.КонецПериода);
	СписокПараметров.Вставить("Организация" , СписокСтруктурныхЕдиниц);
	СписокПараметров.Вставить("ПоддержкаРаботыСоСтруктурнымиПодразделениями", ПоддержкаРаботыСоСтруктурнымиПодразделениями);
	
	Возврат СписокПараметров;
	
КонецФункции

&НаКлиенте
Процедура ПослеВыбораСтруктурногоПодразделения(РезультатВыбора, ДопПараметры) Экспорт
	
	БухгалтерскиеОтчетыКлиент.ПослеВыбораСтруктурногоПодразделения(ЭтаФорма, РезультатВыбора);
	
	Если Не ЗначениеЗаполнено(ИдентификаторЗадания) Тогда
		ОбщегоНазначенияКлиентСервер.УстановитьСостояниеПоляТабличногоДокумента(Элементы.Результат, "НеАктуальность");
	КонецЕсли;
	
	УправлениеФормой(ЭтаФорма);

КонецПроцедуры

&НаКлиенте
Процедура ОтборыПередНачаломДобавленияЗавершение(РезультатЗакрытия, ДопПараметры) Экспорт
	
	БухгалтерскиеОтчетыКлиент.ОтборыПередНачаломДобавленияЗавершение(РезультатЗакрытия, ДопПараметры);
	
	УправлениеФормой(ЭтаФорма);
	
КонецПроцедуры

&НаКлиенте
Процедура ОтборыПередНачаломИзмененияЗавершение(РезультатЗакрытия, ДопПараметры) Экспорт
	
	БухгалтерскиеОтчетыКлиент.ОтборыПередНачаломИзмененияЗавершение(РезультатЗакрытия, ДопПараметры);
	
	УправлениеФормой(ЭтаФорма);
	
КонецПроцедуры

&НаСервере
Процедура СписокВидовСубконтоПриИзмененииСервер()
	
	ИзменениеСхемыКомпоновкиДанныхНаСервере();
	
	ЗаполнитьПризнакиУчета();
	
	ЗаполняемыеНастройки = Новый Структура("Показатели, Отбор",
	                                        Истина, Истина);
	ЗаполнитьНастройкамиПоУмолчанию(ЗаполняемыеНастройки);
	
	УправлениеФормой(ЭтаФорма);
	
КонецПроцедуры

&НаСервере
Процедура ЗаполнитьПризнакиУчета()
	
	МассивСубконто = Новый Массив;
	Для Каждого ЭлементСписка Из Отчет.СписокВидовСубконто Цикл 
		Если ЗначениеЗаполнено(ЭлементСписка.Значение) Тогда
			МассивСубконто.Добавить(ЭлементСписка.Значение);
		КонецЕсли;
	КонецЦикла;
	
	Запрос = Новый Запрос;
	Запрос.Текст = 
		"ВЫБРАТЬ
		|	МАКСИМУМ(ВС1.Ссылка.Количественный) КАК Количественный,
		|	КОЛИЧЕСТВО(РАЗЛИЧНЫЕ ВС1.Ссылка) КАК КоличествоСчетов
		|ИЗ
		|	ПланСчетов.Налоговый.ВидыСубконто КАК ВС1
		|		ВНУТРЕННЕЕ СОЕДИНЕНИЕ ПланСчетов.Налоговый.ВидыСубконто КАК ВС2
		|		ПО ВС1.Ссылка = ВС2.Ссылка
		|		ВНУТРЕННЕЕ СОЕДИНЕНИЕ ПланСчетов.Налоговый.ВидыСубконто КАК ВС3
		|		ПО ВС1.Ссылка = ВС3.Ссылка
		|ГДЕ
		|	ВС1.ВидСубконто = &ВидСубконто1
		|	И ВС2.ВидСубконто = &ВидСубконто2
		|	И ВС3.ВидСубконто = &ВидСубконто3";

	Индекс = 3;
	Пока Индекс <> 0 Цикл
		Если Индекс > МассивСубконто.Количество() Тогда
			Запрос.Текст = СтрЗаменить(Запрос.Текст, "ВС" + Индекс + ".ВидСубконто = &ВидСубконто" + Индекс, "ИСТИНА");	
		КонецЕсли;	
		Индекс = Индекс - 1;
	КонецЦикла;
	Для Индекс = 1 По МассивСубконто.Количество() Цикл
		Запрос.УстановитьПараметр("ВидСубконто" + Индекс, МассивСубконто[Индекс - 1]);
	КонецЦикла;
	
	ЕстьУчетПоПодразделениям = ПоддержкаРаботыСоСтруктурнымиПодразделениями;

	ЕстьКоличество           = Ложь;
	ЕстьСчета                = Ложь;
	
	Если МассивСубконто.Количество() = 0 Тогда
		ЕстьКоличество       = Истина;
		ЕстьСчета            = Истина;
	Иначе
		ВыборкаСчета = Запрос.Выполнить().Выбрать();
		Пока ВыборкаСчета.Следующий() Цикл
			ЕстьКоличество   = ?(ВыборкаСчета.Количественный   = Истина, Истина, Ложь);
			ЕстьСчета        = ?(ВыборкаСчета.КоличествоСчетов = 0     , Ложь  , Истина);  
		КонецЦикла;
	КонецЕсли;
	
КонецПроцедуры

&НаКлиенте
Процедура ПоказатьДиалогОтправкиПоЭлектроннойПочте()
	
	ОписаниеОповещения = Новый ОписаниеОповещения(
		"ОтправитьОтчетыПоПочтеНастройкаУчетнойЗаписиПредложена", БухгалтерскиеОтчетыКлиент, ЭтотОбъект);

	РаботаСПочтовымиСообщениямиКлиент.ПроверитьНаличиеУчетнойЗаписиДляОтправкиПочты(ОписаниеОповещения);
	
КонецПроцедуры

&НаКлиенте
Процедура ЗафиксироватьДлительностьКлючевойОперации()
	
	ОценкаПроизводительностиКлиент.ЗавершитьЗамерВремени(УИДЗамера);
	
КонецПроцедуры