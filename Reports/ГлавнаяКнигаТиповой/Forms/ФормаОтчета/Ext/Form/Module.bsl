﻿
&НаКлиенте
Перем ПараметрыОбработчикаОжидания;

&НаКлиенте
Перем УИДЗамера;

////////////////////////////////////////////////////////////////////////////////
// ОБРАБОТЧИКИ СОБЫТИЙ ФОРМЫ

&НаСервере
Процедура ПриСозданииНаСервере(Отказ, СтандартнаяОбработка)
	
	БухгалтерскиеОтчетыВызовСервера.УстановитьНастройкиПоУмолчанию(ЭтаФорма);
	ДанныеРасшифровки = ПоместитьВоВременноеХранилище(Неопределено, УникальныйИдентификатор);
	
	Отчет.ПоСубсчетам        = Истина;
	Отчет.ПоГруппамКорСчетов = Истина;
	Отчет.Периодичность      = 9;
	Отчет.ВсеПериоды         = Ложь;
	Отчет.РазбитьПоЛистам    = Ложь;
	
КонецПроцедуры

&НаКлиенте
Процедура ПриОткрытии(Отказ)
	
	БухгалтерскиеОтчетыКлиент.ПриОткрытии(ЭтаФорма, Отказ);
	
	Отчет.ПредставлениеСпискаОрганизаций = БухгалтерскиеОтчетыКлиентСервер.ВыгрузитьСписокВСтроку(СписокСтруктурныхЕдиниц);
	
	ОбновитьТекстЗаголовка(ЭтаФорма);
	
	УправлениеФормой(ЭтаФорма);
	
КонецПроцедуры

&НаКлиенте
Процедура ПередЗакрытием(Отказ, ЗавершениеРаботы, ТекстПредупреждения, СтандартнаяОбработка)
	
	ВариантМодифицирован                    = Ложь;
	ПользовательскиеНастройкиМодифицированы = Истина;
	
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
	
	ОбновитьТекстЗаголовка(ЭтаФорма);
	
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
Процедура ПредставлениеСпискаОрганизацийОчистка(Элемент, СтандартнаяОбработка)
	
	СписокСтруктурныхЕдиниц.Очистить();
	Отчет.ПредставлениеСпискаОрганизаций = "";
	
	Если НЕ ЗначениеЗаполнено(ИдентификаторЗадания) Тогда
		ОбщегоНазначенияКлиентСервер.УстановитьСостояниеПоляТабличногоДокумента(Элементы.Результат, "НеАктуальность");
	КонецЕсли;
		
КонецПроцедуры

&НаКлиенте
Процедура ПредставлениеСпискаОрганизацийНачалоВыбора(Элемент, ДанныеВыбора, СтандартнаяОбработка)
	
	ДополнительныеПараметры = Новый Структура;
	ДополнительныеПараметры.Вставить("СписокСтруктурныхЕдиниц"      , СписокСтруктурныхЕдиниц);
	ДополнительныеПараметры.Вставить("ВыборСтруктурныхПодразделений", Ложь); 
	
	БухгалтерскиеОтчетыКлиент.ПредставлениеСпискаОрганизацийНачалоВыбора(ЭтаФорма, СтандартнаяОбработка, ДополнительныеПараметры);
	
КонецПроцедуры

&НаКлиенте
Процедура ПоГруппамСчетовПриИзменении(Элемент)
	
	Если НЕ Отчет.ПоГруппамСчетов И НЕ Отчет.ПоСубсчетам Тогда
		Отчет.ПоСубсчетам = Истина;
	КонецЕсли;

	Если Не ЗначениеЗаполнено(ИдентификаторЗадания) Тогда
		ОбщегоНазначенияКлиентСервер.УстановитьСостояниеПоляТабличногоДокумента(Элементы.Результат, "НеАктуальность");
	КонецЕсли;

КонецПроцедуры

&НаКлиенте
Процедура ПоСубсчетамПриИзменении(Элемент)
	
	Если НЕ Отчет.ПоГруппамСчетов И НЕ Отчет.ПоСубсчетам Тогда
		Отчет.ПоГруппамСчетов = Истина;
	КонецЕсли;

	Если Не ЗначениеЗаполнено(ИдентификаторЗадания) Тогда
		ОбщегоНазначенияКлиентСервер.УстановитьСостояниеПоляТабличногоДокумента(Элементы.Результат, "НеАктуальность");
	КонецЕсли;

КонецПроцедуры

&НаКлиенте
Процедура ПоГруппамКорСчетовПриИзменении(Элемент)
	
	Если НЕ Отчет.ПоГруппамКорСчетов И НЕ Отчет.ПоСубсчетамКорСчетов Тогда
		Отчет.ПоСубсчетамКорСчетов = Истина;
	КонецЕсли;

	Если Не ЗначениеЗаполнено(ИдентификаторЗадания) Тогда
		ОбщегоНазначенияКлиентСервер.УстановитьСостояниеПоляТабличногоДокумента(Элементы.Результат, "НеАктуальность");
	КонецЕсли;

КонецПроцедуры

&НаКлиенте
Процедура ПоСубсчетамКорСчетовПриИзменении(Элемент)
	
	Если НЕ Отчет.ПоГруппамКорСчетов И НЕ Отчет.ПоСубсчетамКорСчетов Тогда
		Отчет.ПоГруппамКорСчетов = Истина;
	КонецЕсли;

	Если Не ЗначениеЗаполнено(ИдентификаторЗадания) Тогда
		ОбщегоНазначенияКлиентСервер.УстановитьСостояниеПоляТабличногоДокумента(Элементы.Результат, "НеАктуальность");
	КонецЕсли;

КонецПроцедуры

&НаКлиенте
Процедура ПериодичностьПриИзменении(Элемент)

	Если Не ЗначениеЗаполнено(ИдентификаторЗадания) Тогда
		ОбщегоНазначенияКлиентСервер.УстановитьСостояниеПоляТабличногоДокумента(Элементы.Результат, "НеАктуальность");
	КонецЕсли;
	
	Если Отчет.Периодичность = 0 Тогда
		Отчет.ВсеПериоды = Ложь;
	КонецЕсли;
	
	УправлениеФормой(ЭтаФорма);

КонецПроцедуры

&НаКлиенте
Процедура ВсеПериодыПриИзменении(Элемент)

	Если Не ЗначениеЗаполнено(ИдентификаторЗадания) Тогда
		ОбщегоНазначенияКлиентСервер.УстановитьСостояниеПоляТабличногоДокумента(Элементы.Результат, "НеАктуальность");
	КонецЕсли;

КонецПроцедуры

&НаКлиенте
Процедура РазбитьПоЛистамПриИзменении(Элемент)

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

&НаКлиенте
Процедура ВыводитьЗаголовокПриИзменении(Элемент)
	
	ОбластьЗаголовок = Результат.Области.Найти("Заголовок");
	Если ОбластьЗаголовок <> Неопределено Тогда
		ОбластьЗаголовок.Видимость = ВыводитьЗаголовок; 
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


////////////////////////////////////////////////////////////////////////////////
// ОБРАБОТЧИКИ СОБЫТИЙ ТАБЛИЦЫ ФОРМЫ РАЗВЕРНУТОЕ САЛЬДО

&НаКлиенте
Процедура РазвернутоеСальдоПриИзменении(Элемент)
	
	Если Элемент.ТекущийЭлемент.Имя = "РазвернутоеСальдоПоСубсчетам" Тогда
		БухгалтерскиеОтчетыКлиент.ТабличноеПолеПоСчетамПоСубсчетамПриИзменении(ЭтаФорма, "РазвернутоеСальдо", Элемент);
	КонецЕсли;

	Если Не ЗначениеЗаполнено(ИдентификаторЗадания) Тогда
		ОбщегоНазначенияКлиентСервер.УстановитьСостояниеПоляТабличногоДокумента(Элементы.Результат, "НеАктуальность");
	КонецЕсли;

КонецПроцедуры

&НаКлиенте
Процедура РазвернутоеСальдоСчетПриИзменении(Элемент)

	БухгалтерскиеОтчетыКлиент.ТабличноеПолеПоСчетамСчетПриИзменении(ЭтаФорма, "РазвернутоеСальдо", Элемент);
	Элементы.РазвернутоеСальдо.ТекущиеДанные.Использование 	= Истина;
	
КонецПроцедуры

&НаКлиенте
Процедура РазвернутоеСальдоПредставлениеНачалоВыбора(Элемент, ДанныеВыбора, СтандартнаяОбработка)

	БухгалтерскиеОтчетыКлиент.ТабличноеПолеПоСчетамПредставлениеНачалоВыбора(ЭтаФорма, "РазвернутоеСальдо", Элемент, ДанныеВыбора, СтандартнаяОбработка);

КонецПроцедуры

&НаКлиенте
Процедура РазвернутоеСальдоПредставлениеОчистка(Элемент, СтандартнаяОбработка)

	БухгалтерскиеОтчетыКлиент.ТабличноеПолеПоСчетамПредставлениеОчистка(ЭтаФорма, "РазвернутоеСальдо", Элемент, СтандартнаяОбработка);

КонецПроцедуры

&НаКлиенте
Процедура РазвернутоеСальдоПредставлениеОбработкаВыбора(Элемент, ВыбранноеЗначение, СтандартнаяОбработка)

	БухгалтерскиеОтчетыКлиент.ТабличноеПолеПоСчетамПредставлениеОбработкаВыбора(ЭтаФорма, "РазвернутоеСальдо", Элемент, ВыбранноеЗначение, СтандартнаяОбработка);

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
	
	УИДЗамера = ОценкаПроизводительностиКлиент.НачатьЗамерВремени(Ложь, "Отчет ""главная книга (бух.)"" (формирование)");
		
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
Процедура РазвернутоеСальдоСнятьФлажки(Команда)
	
	Для Каждого СтрокаТаблицы Из Отчет.РазвернутоеСальдо Цикл
		СтрокаТаблицы.Использование = Ложь;
	КонецЦикла;
	
	Если Не ЗначениеЗаполнено(ИдентификаторЗадания) Тогда
		ОбщегоНазначенияКлиентСервер.УстановитьСостояниеПоляТабличногоДокумента(Элементы.Результат, "НеАктуальность");
	КонецЕсли;
	
КонецПроцедуры

&НаКлиенте
Процедура РазвернутоеСальдоУстановитьФлажки(Команда)
	
	Для Каждого СтрокаТаблицы Из Отчет.РазвернутоеСальдо Цикл
		СтрокаТаблицы.Использование = Истина;
	КонецЦикла;
	
	Если Не ЗначениеЗаполнено(ИдентификаторЗадания) Тогда
		ОбщегоНазначенияКлиентСервер.УстановитьСостояниеПоляТабличногоДокумента(Элементы.Результат, "НеАктуальность");
	КонецЕсли;
	
КонецПроцедуры

&НаКлиенте
Процедура ОтправитьПоЭлектроннойПочте(Команда)

	ПоказатьДиалогОтправкиПоЭлектроннойПочте();
	
КонецПроцедуры


////////////////////////////////////////////////////////////////////////////////
// СЛУЖЕБНЫЕ ПРОЦЕДУРЫ И ФУНКЦИИ

&НаКлиентеНаСервереБезКонтекста
Процедура УправлениеФормой(Форма)
	
	Форма.Элементы.ВыводитьПодписиРуководителей.Доступность = Форма.ВыводитьПодписи;
	
	Форма.Элементы.ВсеПериоды.Доступность = Форма.Отчет.Периодичность <> 0;
	
КонецПроцедуры

&НаКлиенте
Процедура ВыбратьПериодЗавершение(РезультатВыбора, ДопПараметры) Экспорт
	
	Если РезультатВыбора = Неопределено Тогда
		Возврат;
	КонецЕсли;
	ЗаполнитьЗначенияСвойств(Отчет, РезультатВыбора, "НачалоПериода, КонецПериода");
	
	ОбновитьТекстЗаголовка(ЭтаФорма); 
	Если Не ЗначениеЗаполнено(ИдентификаторЗадания) Тогда
		ОбщегоНазначенияКлиентСервер.УстановитьСостояниеПоляТабличногоДокумента(Элементы.Результат, "НеАктуальность");
	КонецЕсли;

КонецПроцедуры

&НаКлиентеНаСервереБезКонтекста
Процедура ОбновитьТекстЗаголовка(Форма)
	
	Отчет = Форма.Отчет;
	
	ЗаголовокОтчета = НСтр("ru = 'Главная книга %1'");
	ЗаголовокОтчета = СтроковыеФункцииКлиентСервер.ПодставитьПараметрыВСтроку(
		ЗаголовокОтчета, БухгалтерскиеОтчетыКлиентСервер.ПолучитьПредставлениеПериода(Отчет.НачалоПериода, Отчет.КонецПериода));

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
Функция СформироватьОтчетНаСервере() Экспорт
	
	Если НЕ ПроверитьЗаполнение() Тогда 
		Возврат Новый Структура("ЗаданиеВыполнено", Истина);
	КонецЕсли;
	
	ИдентификаторЗадания = Неопределено;
	ИБФайловая = ОбщегоНазначения.ИнформационнаяБазаФайловая();
	ДлительныеОперации.ОтменитьВыполнениеЗадания(ИдентификаторЗадания);
	ОбщегоНазначенияКлиентСервер.УстановитьСостояниеПоляТабличногоДокумента(Элементы.Результат, "НеИспользовать");
	
	ПараметрыОтчета = ПодготовитьПараметрыОтчета();
	
	Если ИБФайловая Тогда
		АдресХранилища = ПоместитьВоВременноеХранилище(Неопределено, УникальныйИдентификатор);
		Отчеты.ГлавнаяКнигаТиповой.СформироватьОтчет(ПараметрыОтчета, АдресХранилища);
		РезультатВыполнения = Новый Структура("ЗаданиеВыполнено", Истина);
	Иначе
		РезультатВыполнения = ДлительныеОперации.ЗапуститьВыполнениеВФоне(
			УникальныйИдентификатор, 
			"Отчеты.ГлавнаяКнигаТиповой.СформироватьОтчет",
			ПараметрыОтчета, 
			БухгалтерскиеОтчетыКлиентСервер.ПолучитьНаименованиеЗаданияВыполненияОтчета(ЭтаФорма));
		
		АдресХранилища       = РезультатВыполнения.АдресХранилища;
		ИдентификаторЗадания = РезультатВыполнения.ИдентификаторЗадания;
	КонецЕсли;
	
	Если РезультатВыполнения.ЗаданиеВыполнено Тогда
		ЗагрузитьПодготовленныеДанные();
	КонецЕсли;
	
	Элементы.Сформировать.КнопкаПоУмолчанию = Истина;
	
	Возврат РезультатВыполнения;
	
КонецФункции

&НаСервере
Функция ПодготовитьПараметрыОтчета()
	
	ПараметрыОтчета = Новый Структура;
	ПараметрыОтчета.Вставить("НачалоПериода"               , Отчет.НачалоПериода);
	ПараметрыОтчета.Вставить("КонецПериода"                , Отчет.КонецПериода);
	ПараметрыОтчета.Вставить("Периодичность"               , Отчет.Периодичность);
	ПараметрыОтчета.Вставить("СписокСтруктурныхЕдиниц"     , СписокСтруктурныхЕдиниц);
	ПараметрыОтчета.Вставить("ВсеПериоды"                  , Отчет.ВсеПериоды);
	ПараметрыОтчета.Вставить("РазвернутоеСальдо"           , Отчет.РазвернутоеСальдо.Выгрузить());
	ПараметрыОтчета.Вставить("РазбитьПоЛистам"             , Отчет.РазбитьПоЛистам);
	ПараметрыОтчета.Вставить("ПоГруппамСчетов"             , Отчет.ПоГруппамСчетов);
	ПараметрыОтчета.Вставить("ПоСубсчетам"                 , Отчет.ПоСубсчетам);
	ПараметрыОтчета.Вставить("ПоГруппамКорСчетов"          , Отчет.ПоГруппамКорСчетов);
	ПараметрыОтчета.Вставить("ПоСубсчетамКорСчетов"        , Отчет.ПоСубсчетамКорСчетов);
	ПараметрыОтчета.Вставить("ВыводитьЗаголовок"           , ВыводитьЗаголовок);
	ПараметрыОтчета.Вставить("ВыводитьПодписи"             , ВыводитьПодписи);
	ПараметрыОтчета.Вставить("ВыводитьПодписиРуководителей", ВыводитьПодписиРуководителей);
	ПараметрыОтчета.Вставить("ДанныеРасшифровки"           , ДанныеРасшифровки);
	ПараметрыОтчета.Вставить("ИдентификаторОтчета"         , БухгалтерскиеОтчетыКлиентСервер.ПолучитьИдентификаторОбъекта(ЭтаФорма));
	
	Возврат ПараметрыОтчета;
	
КонецФункции

&НаСервере
Процедура ЗагрузитьПодготовленныеДанные()

	Результат = ПолучитьИзВременногоХранилища(АдресХранилища).Результат;
	
	Если Результат.Области.Найти("Заголовок") <> Неопределено Тогда
		Результат.Область("Заголовок").Видимость = ВыводитьЗаголовок;
	КонецЕсли;
	
	ИдентификаторЗадания = Неопределено;
	
	ОбщегоНазначенияКлиентСервер.УстановитьСостояниеПоляТабличногоДокумента(Элементы.Результат, "НеИспользовать");
	
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
Процедура ПослеВыбораСтруктурногоПодразделения(РезультатВыбора, ДопПараметры) Экспорт
	
	БухгалтерскиеОтчетыКлиент.ПослеВыбораСтруктурногоПодразделения(ЭтаФорма, РезультатВыбора);
	
	Если Не ЗначениеЗаполнено(ИдентификаторЗадания) Тогда
		ОбщегоНазначенияКлиентСервер.УстановитьСостояниеПоляТабличногоДокумента(Элементы.Результат, "НеАктуальность");
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
