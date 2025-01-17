﻿///////////////////////////////////////////////////////////////////////////////////////////////////////
// Copyright (c) 2020, ООО 1С-Софт
// Все права защищены. Эта программа и сопроводительные материалы предоставляются 
// в соответствии с условиями лицензии Attribution 4.0 International (CC BY 4.0)
// Текст лицензии доступен по ссылке:
// https://creativecommons.org/licenses/by/4.0/legalcode
///////////////////////////////////////////////////////////////////////////////////////////////////////

#Область ПрограммныйИнтерфейс

// Определить объекты метаданных, в формах списков которых
// будут выведены команды объединения дублей и замены ссылок
// см. ПоискИУдалениеДублейКлиент.ОбъединитьВыделенные и ПоискИУдалениеДублейКлиент.ЗаменитьВыделенные
// 
// Параметры:
//  Объекты - Массив из ОбъектМетаданных
//
// Пример:
//	Объекты.Добавить(Метаданные.Справочники._ДемоНоменклатура);
//	Объекты.Добавить(Метаданные.Справочники._ДемоКонтрагенты);
//
Процедура ПриОпределенииОбъектовСКомандойГрупповогоИзмененияОбъектов(Объекты) Экспорт

	

КонецПроцедуры

// Определить объекты метаданных, в модулях менеджеров которых ограничивается возможность 
// редактирования реквизитов при групповом изменении.
//
// Параметры:
//   Объекты - Соответствие из КлючИЗначение - в качестве ключа указать полное имя объекта метаданных,
//                            подключенного к подсистеме "Групповое изменение объектов". 
//                            Дополнительно в значении могут быть перечислены имена экспортных функций:
//                            "РеквизитыНеРедактируемыеВГрупповойОбработке",
//                            "РеквизитыРедактируемыеВГрупповойОбработке".
//                            Каждое имя должно начинаться с новой строки.
//                            Если указано "*", значит, в модуле менеджера определены обе функции.
//
// Пример: 
//   Объекты.Вставить(Метаданные.Документы.ЗаказПокупателя.ПолноеИмя(), "*"); // определены обе функции.
//   Объекты.Вставить(Метаданные.БизнесПроцессы.ЗаданиеСРолевойАдресацией.ПолноеИмя(), "РеквизитыРедактируемыеВГрупповойОбработке");
//   Объекты.Вставить(Метаданные.Справочники.Партнеры.ПолноеИмя(), "РеквизитыРедактируемыеВГрупповойОбработке
//		|РеквизитыНеРедактируемыеВГрупповойОбработке");
//
Процедура ПриОпределенииОбъектовСРедактируемымиРеквизитами(Объекты) Экспорт
	
	Объекты.Вставить(Метаданные.Документы.Встреча.ПолноеИмя(), "РеквизитыРедактируемыеВГрупповойОбработке");
	Объекты.Вставить(Метаданные.Документы.ЗапланированноеВзаимодействие.ПолноеИмя(), "РеквизитыРедактируемыеВГрупповойОбработке");
	Объекты.Вставить(Метаданные.Документы.ТелефонныйЗвонок.ПолноеИмя(), "РеквизитыРедактируемыеВГрупповойОбработке");
	Объекты.Вставить(Метаданные.Документы.ЭлектронноеПисьмоВходящее.ПолноеИмя(), "РеквизитыРедактируемыеВГрупповойОбработке");
	Объекты.Вставить(Метаданные.Документы.ЭлектронноеПисьмоИсходящее.ПолноеИмя(), "РеквизитыРедактируемыеВГрупповойОбработке");
	Объекты.Вставить(Метаданные.Справочники.АвансовыйОтчетПрисоединенныеФайлы.ПолноеИмя(), "РеквизитыРедактируемыеВГрупповойОбработке");
	Объекты.Вставить(Метаданные.Справочники.АктСверкиВзаиморасчетовПрисоединенныеФайлы.ПолноеИмя(), "РеквизитыРедактируемыеВГрупповойОбработке");
	Объекты.Вставить(Метаданные.Справочники.БанковскиеСчетаПрисоединенныеФайлы.ПолноеИмя(), "РеквизитыРедактируемыеВГрупповойОбработке");
	Объекты.Вставить(Метаданные.Справочники.ВнешниеПользователи.ПолноеИмя(), "РеквизитыНеРедактируемыеВГрупповойОбработке");
	Объекты.Вставить(Метаданные.Справочники.ВстречаПрисоединенныеФайлы.ПолноеИмя(), "РеквизитыРедактируемыеВГрупповойОбработке");
	Объекты.Вставить(Метаданные.Справочники.ГруппыВнешнихПользователей.ПолноеИмя(), "РеквизитыНеРедактируемыеВГрупповойОбработке");
	Объекты.Вставить(Метаданные.Справочники.ДоговорыКонтрагентовПрисоединенныеФайлы.ПолноеИмя(), "РеквизитыРедактируемыеВГрупповойОбработке");
	Объекты.Вставить(Метаданные.Справочники.ДополнительныеОтчетыИОбработки.ПолноеИмя(), "РеквизитыРедактируемыеВГрупповойОбработке");
	Объекты.Вставить(Метаданные.Справочники.ЗакладкиВзаимодействий.ПолноеИмя(), "РеквизитыНеРедактируемыеВГрупповойОбработке");
	Объекты.Вставить(Метаданные.Справочники.ЗапланированноеВзаимодействиеПрисоединенныеФайлы.ПолноеИмя(), "РеквизитыРедактируемыеВГрупповойОбработке");
	Объекты.Вставить(Метаданные.Справочники.ИдентификаторыОбъектовМетаданных.ПолноеИмя(), "РеквизитыРедактируемыеВГрупповойОбработке");
	Объекты.Вставить(Метаданные.Справочники.ИсполнительныйЛистПрисоединенныеФайлы.ПолноеИмя(), "РеквизитыРедактируемыеВГрупповойОбработке");
	Объекты.Вставить(Метаданные.Справочники.КонтрагентыПрисоединенныеФайлы.ПолноеИмя(), "РеквизитыРедактируемыеВГрупповойОбработке");
	Объекты.Вставить(Метаданные.Справочники.НематериальныеАктивыПрисоединенныеФайлы.ПолноеИмя(), "РеквизитыРедактируемыеВГрупповойОбработке");
	Объекты.Вставить(Метаданные.Справочники.НоменклатураПрисоединенныеФайлы.ПолноеИмя(), "РеквизитыРедактируемыеВГрупповойОбработке");
	Объекты.Вставить(Метаданные.Справочники.ОрганизацииПрисоединенныеФайлы.ПолноеИмя(), "РеквизитыРедактируемыеВГрупповойОбработке");
	Объекты.Вставить(Метаданные.Справочники.ОсновныеСредстваПрисоединенныеФайлы.ПолноеИмя(), "РеквизитыРедактируемыеВГрупповойОбработке");
	Объекты.Вставить(Метаданные.Справочники.ПапкиЭлектронныхПисем.ПолноеИмя(), "РеквизитыНеРедактируемыеВГрупповойОбработке");
	Объекты.Вставить(Метаданные.Справочники.ПодразделенияОрганизацийПрисоединенныеФайлы.ПолноеИмя(), "РеквизитыРедактируемыеВГрупповойОбработке");
	Объекты.Вставить(Метаданные.Справочники.Пользователи.ПолноеИмя(), "РеквизитыНеРедактируемыеВГрупповойОбработке");
	Объекты.Вставить(Метаданные.Справочники.ПравилаОбработкиЭлектроннойПочты.ПолноеИмя(), "РеквизитыНеРедактируемыеВГрупповойОбработке");
	Объекты.Вставить(Метаданные.Справочники.ПрограммыЭлектроннойПодписиИШифрования.ПолноеИмя(), "РеквизитыРедактируемыеВГрупповойОбработке");
	Объекты.Вставить(Метаданные.Справочники.СертификатыКлючейЭлектроннойПодписиИШифрования.ПолноеИмя(), "РеквизитыНеРедактируемыеВГрупповойОбработке");
	Объекты.Вставить(Метаданные.Справочники.СотрудникиОрганизацийПрисоединенныеФайлы.ПолноеИмя(), "РеквизитыРедактируемыеВГрупповойОбработке");
	Объекты.Вставить(Метаданные.Справочники.СтроковыеКонтактыВзаимодействий.ПолноеИмя(), "РеквизитыРедактируемыеВГрупповойОбработке");
	Объекты.Вставить(Метаданные.Справочники.СценарииОбменовДанными.ПолноеИмя(), "РеквизитыНеРедактируемыеВГрупповойОбработке");
	Объекты.Вставить(Метаданные.Справочники.ТелефонныйЗвонокПрисоединенныеФайлы.ПолноеИмя(), "РеквизитыРедактируемыеВГрупповойОбработке");
	Объекты.Вставить(Метаданные.Справочники.ТомаХраненияФайлов.ПолноеИмя(), "РеквизитыРедактируемыеВГрупповойОбработке");
	Объекты.Вставить(Метаданные.Справочники.УчетныеЗаписиЭлектроннойПочты.ПолноеИмя(), "РеквизитыРедактируемыеВГрупповойОбработке");
	Объекты.Вставить(Метаданные.Справочники.ФизическиеЛицаПрисоединенныеФайлы.ПолноеИмя(), "РеквизитыРедактируемыеВГрупповойОбработке");
	Объекты.Вставить(Метаданные.Справочники.ЭлектронноеПисьмоВходящееПрисоединенныеФайлы.ПолноеИмя(), "РеквизитыРедактируемыеВГрупповойОбработке");
	Объекты.Вставить(Метаданные.Справочники.ЭлектронноеПисьмоИсходящееПрисоединенныеФайлы.ПолноеИмя(), "РеквизитыРедактируемыеВГрупповойОбработке");
	Объекты.Вставить(Метаданные.Справочники.ЭСФПрисоединенныеФайлы.ПолноеИмя(), "РеквизитыРедактируемыеВГрупповойОбработке");	
	
	Если ОбщегоНазначенияБККлиентСервер.ЭтоПростаяВерсияКонфигурации() Тогда
		Объекты.Вставить(Метаданные.Документы.ПоступлениеДопРасходов.ПолноеИмя(), "РеквизитыРедактируемыеВГрупповойОбработке");
	КонецЕсли;
	
КонецПроцедуры

// Переопределяемая процедура, вызываемая из одноименного обработчика события формы.
//
// Параметры:
// 	Форма - форма, из обработчика события которой происходит вызов процедуры.
//	см. справочную информацию по событиям управляемой формы.
//
Процедура ВидимостьЭлементовГрупповоеИзменение(Форма, Отказ, СтандартнаяОбработка) Экспорт
	
	Если ОбщегоНазначенияБККлиентСервер.ЭтоПростаяВерсияКонфигурации() Тогда
		
		МассивЭлементов = Новый Массив;
		МассивЭлементов.Добавить("ФормаИзменитьВыделенные");
		МассивЭлементов.Добавить("СписокКонтекстноеМенюИзменитьВыделенные");
		
		Для каждого СкрываемыйЭлемент Из МассивЭлементов Цикл
			НайденныйЭлемент = Форма.Элементы.Найти(СкрываемыйЭлемент);
			Если НайденныйЭлемент <> Неопределено Тогда
				НайденныйЭлемент.Видимость = Ложь;
			КонецЕсли;
		КонецЦикла;
		
	КонецЕсли;
	
КонецПроцедуры

#КонецОбласти
