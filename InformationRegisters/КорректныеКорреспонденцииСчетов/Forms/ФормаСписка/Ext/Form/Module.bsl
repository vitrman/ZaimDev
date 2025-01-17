﻿////////////////////////////////////////////////////////////////////////////////

////////////////////////////////////////////////////////////////////////////////
// ОБРАБОТЧИКИ СОБЫТИЙ ФОРМЫ

&НаСервере
Процедура ПриСозданииНаСервере(Отказ, СтандартнаяОбработка)
	Элементы.Заполнить.Доступность = ПравоДоступа("Редактирование", Метаданные.РегистрыСведений.КорректныеКорреспонденцииСчетов);
КонецПроцедуры

&НаКлиенте
Процедура ОбработкаОповещения(ИмяСобытия, Параметр, Источник)
	
	Если ИмяСобытия = "ОбновлениеКорреспонденцииСчетов" Тогда
		Элементы.Список.Обновить();			
	КонецЕсли;
	
КонецПроцедуры

////////////////////////////////////////////////////////////////////////////////
// ОБРАБОТЧИКИ СОБЫТИЙ ЭЛЕМЕНТОВ ШАПКИ ФОРМЫ

////////////////////////////////////////////////////////////////////////////////
// ОБРАБОТЧИКИ СОБЫТИЙ ТАБЛИЦЫ ФОРМЫ <ИМЯ ТАБЛИЦЫ ФОРМЫ>

////////////////////////////////////////////////////////////////////////////////
// ОБРАБОТЧИКИ КОМАНД ФОРМЫ

&НаКлиенте
Процедура Заполнить(Команда)
	
	Состояние(НСтр("ru = 'Выполняется заполнение корреспонденций счетов'"));
	
	ЗаполнитьНаСервере();
		
	Элементы.Список.Обновить();	
	
	Состояние(НСтр("ru = 'Заполнение корреспонденций счетов выполнено'"));
	
КонецПроцедуры

////////////////////////////////////////////////////////////////////////////////
// СЛУЖЕБНЫЕ ПРОЦЕДУРЫ И ФУНКЦИИ

&НаСервере
Процедура ЗаполнитьНаСервере()
	
	РегистрыСведений.КорректныеКорреспонденцииСчетов.ЗаполнитьКорреспонденциюПроводок();
	
КонецПроцедуры
