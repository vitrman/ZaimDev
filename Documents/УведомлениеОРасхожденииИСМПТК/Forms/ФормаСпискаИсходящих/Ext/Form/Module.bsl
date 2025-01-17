﻿////////////////////////////////////////////////////////////////////////////////
// ОБРАБОТЧИКИ СОБЫТИЙ ФОРМЫ

&НаСервере
Процедура ПриСозданииНаСервере(Отказ, СтандартнаяОбработка)
	
	Если Параметры.Свойство("АвтоТест") Тогда
		Возврат;
	КонецЕсли;
	
	УстановитьВидимостьКнопокИзмененияСтатуса();
	
	Если Параметры.Отбор.Свойство("Организация") Тогда
		Организация = Параметры.Отбор.Организация;
	КонецЕсли;
	
	Если Параметры.Свойство("Заголовок") Тогда
		ЭтаФорма.Заголовок = Параметры.Заголовок;
	КонецЕсли;
	
КонецПроцедуры

&НаКлиенте
Процедура ОбработкаОповещения(ИмяСобытия, Параметр, Источник)
	
	Если ИмяСобытия = ИнтеграцияИСМПТККлиентСервер.ИмяСобытияЗаписьУведомлениеОРасхождении() Тогда
		
		Элементы.Список.Обновить();
				
	КонецЕсли;
	
КонецПроцедуры

////////////////////////////////////////////////////////////////////////////////
// ОБРАБОТЧИКИ СОБЫТИЙ ТАБЛИЦЫ ФОРМЫ

&НаКлиенте
Процедура СписокПриАктивизацииСтроки(Элемент)

	УстановитьВидимостьКнопокИзмененияСтатуса();
	
	ТекущиеДанные = Элементы.Список.ТекущиеДанные;
	
	Если ТекущиеДанные = Неопределено Тогда
		ИнтерфейсИСМПТККлиентСервер.УстановитьСвойствоЭлементаФормы(Элементы, "СписокДокументУОРОбновить", "Доступность", Ложь);
	Иначе
		ИнтерфейсИСМПТККлиентСервер.УстановитьСвойствоЭлементаФормы(Элементы, "СписокДокументУОРОбновить", "Доступность", Истина);
	КонецЕсли;
	 	
КонецПроцедуры

////////////////////////////////////////////////////////////////////////////////
// ОБРАБОТЧИКИ СОБЫТИЙ ЭЛЕМЕНТОВ ШАПКИ ФОРМЫ

&НаКлиенте
Процедура ОрганизацияПриИзменении(Элемент)	
	
	УстановитьБыстрыйОтбор("Организация", Организация);
	
КонецПроцедуры

&НаКлиенте
Процедура КонтрагентПриИзменении(Элемент)
	
	УстановитьБыстрыйОтбор("Контрагент", Контрагент);
	
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

&НаСервере
Процедура УстановитьВидимостьКнопокИзмененияСтатуса()
	
	Если Элементы.Список.ВыделенныеСтроки.Количество() > 0 Тогда
		
		ПервыйВыделенныйУОР = Элементы.Список.ВыделенныеСтроки[0];
		СоответвствиеСтатусов = ИнтеграцияИСМПТК.РазрешенныеДействияПоСтатусамУведомленияОРасхождении(ПервыйВыделенныйУОР.Направление, ПервыйВыделенныйУОР.ВидОперации);
		//УстановитьВидимостьКнопки(СоответвствиеСтатусов, "СписокДокументУведомлениеОРасхожденииИСМПТПодтвердить", ПервыйВыделенныйУОР, ИнтеграцияИСМПТККлиентСервер.ДействиеПодтверждение());
	
	Иначе
	
		//ИнтерфейсИСМПТККлиентСервер.УстановитьСвойствоЭлементаФормы(Элементы, "СписокДокументУведомлениеОРасхожденииИСМПТПодтвердить",  "Видимость", Ложь);

	КонецЕсли;

	ИнтерфейсИСМПТККлиентСервер.УстановитьСвойствоЭлементаФормы(Элементы, "СписокУОРОтправить",  "Видимость", Истина);
	
КонецПроцедуры