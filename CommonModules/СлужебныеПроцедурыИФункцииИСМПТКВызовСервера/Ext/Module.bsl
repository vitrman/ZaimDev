﻿
Процедура СоздатьЗаписьЖурналаРегистрации(
	ИмяСобытия, 
	УровеньСтрокой = "", 
	ОбъектМетаданных = Неопределено, 
	Данные = Неопределено, 
	Комментарий = "", 
	РежимТранзакции = Неопределено) Экспорт
	
	Если УровеньСтрокой = "Информация" Тогда
		Уровень = УровеньЖурналаРегистрации.Информация;	
	ИначеЕсли УровеньСтрокой = "Ошибка" Тогда
		Уровень = УровеньЖурналаРегистрации.Ошибка;	
	ИначеЕсли УровеньСтрокой = "Предупреждение" Тогда
		Уровень = УровеньЖурналаРегистрации.Предупреждение;	
	ИначеЕсли УровеньСтрокой = "Примечание" Тогда
		Уровень = УровеньЖурналаРегистрации.Примечание;	
	Иначе
		Уровень = УровеньЖурналаРегистрации.Информация;	
	КонецЕсли;	
		
	ЗаписьЖурналаРегистрации(ИмяСобытия, Уровень, ОбъектМетаданных, Данные, Комментарий, РежимТранзакции); 
	
КонецПроцедуры
