﻿////////////////////////////////////////////////////////////////////////////////
// ОБРАБОТЧИКИ СОБЫТИЙ ФОРМЫ

&НаСервере
Процедура ПриСозданииНаСервере(Отказ, СтандартнаяОбработка)
	
	Если Параметры.Свойство("АвтоТест") Тогда
		Возврат;
	КонецЕсли;
	
	Если Параметры.Отбор.Свойство("Организация") Тогда
		Организация = Параметры.Отбор.Организация;
	КонецЕсли;
	
	Если Параметры.Свойство("Заголовок") Тогда
		ЭтаФорма.Заголовок = Параметры.Заголовок;
	КонецЕсли;
	
КонецПроцедуры

&НаКлиенте
Процедура ОбработкаОповещения(ИмяСобытия, Параметр, Источник)
	
	Если ИмяСобытия = ИнтеграцияИСМПТККлиентСервер.ИмяСобытияЗаписьУведомлениеОВыводеИзОборота() Тогда
		
		Элементы.Список.Обновить();
				
	КонецЕсли;
	
КонецПроцедуры

////////////////////////////////////////////////////////////////////////////////
// ОБРАБОТЧИКИ СОБЫТИЙ ЭЛЕМЕНТОВ ШАПКИ ФОРМЫ

&НаКлиенте
Процедура ОрганизацияПриИзменении(Элемент)	
	
	УстановитьБыстрыйОтбор("Организация", Организация);
	
КонецПроцедуры

&НаКлиенте
Процедура СостояниеПриИзменении(Элемент)
	
	УстановитьБыстрыйОтбор("Состояние", Состояние);
	
КонецПроцедуры

////////////////////////////////////////////////////////////////////////////////
// СЛУЖЕБНЫЕ ПРОЦЕДУРЫ И ФУНКЦИИ

&НаКлиенте
Процедура УстановитьБыстрыйОтбор(ВидЭлемента, ЗначениеЭлемента)
	
	ИнтеграцияИСМПТККлиентСерверПереопределяемый.ИзменитьЭлементОтбораСписка(Список, ВидЭлемента, ЗначениеЭлемента, ЗначениеЗаполнено(ЗначениеЭлемента));
	
КонецПроцедуры

&НаКлиенте
Процедура СписокПриАктивизацииСтроки(Элемент)
	
	ТекущиеДанные = Элементы.Список.ТекущиеДанные;
	
	Если ТекущиеДанные = Неопределено Тогда
		ИнтерфейсИСМПТККлиентСервер.УстановитьСвойствоЭлементаФормы(Элементы, "СписокУОВОбновить", "Доступность", Ложь);
	Иначе
		ИнтерфейсИСМПТККлиентСервер.УстановитьСвойствоЭлементаФормы(Элементы, "СписокУОВОбновить", "Доступность", Истина);
	КонецЕсли;
	
КонецПроцедуры
