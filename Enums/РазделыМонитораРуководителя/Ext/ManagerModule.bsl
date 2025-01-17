﻿#Если Сервер Или ТолстыйКлиентОбычноеПриложение Или ВнешнееСоединение Тогда

#Область ПрограммныйИнтерфейс

// Возвращает массив разделов монитора руководителя по умолчанию
// Возвращаемое значение:
// Массив - Список разделов монитора руководителя доступных по умолчанию
Функция РазделыМонитораРуководителяПоУмолчанию() Экспорт
	
	РазделыПоУмолчанию = Новый Массив;
	РазделыПоУмолчанию.Добавить(ОстаткиДенежныхСредств);
	РазделыПоУмолчанию.Добавить(ПродажиПоКонтрагентам);
	РазделыПоУмолчанию.Добавить(ЗадолженностьПокупателей);
	РазделыПоУмолчанию.Добавить(ПросроченнаяЗадолженностьПокупателей);
	РазделыПоУмолчанию.Добавить(ЗадолженностьПоставщикам);
	РазделыПоУмолчанию.Добавить(ПросроченнаяЗадолженностьПоставщикам);
	
	Возврат РазделыПоУмолчанию;
	
КонецФункции

// Возвращает массив оборотных разделов монитора руководителя
// Возвращаемое значение:
// Массив - Список оборотных разделов монитора руководителя
Функция ОборотныеРазделы() Экспорт
	
	ОборотныеРазделы = Новый Массив;
	ОборотныеРазделы.Добавить(ПродажиПоКонтрагентам);
	
	Возврат ОборотныеРазделы;
	
КонецФункции

#КонецОбласти

#КонецЕсли