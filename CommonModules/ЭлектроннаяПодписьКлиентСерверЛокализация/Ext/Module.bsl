﻿///////////////////////////////////////////////////////////////////////////////////////////////////////
// Copyright (c) 2022, ООО 1С-Софт
// Все права защищены. Эта программа и сопроводительные материалы предоставляются 
// в соответствии с условиями лицензии Attribution 4.0 International (CC BY 4.0)
// Текст лицензии доступен по ссылке:
// https://creativecommons.org/licenses/by/4.0/legalcode
///////////////////////////////////////////////////////////////////////////////////////////////////////

#Область СлужебныеПроцедурыИФункции

Процедура ПриПолученииПредставленияСертификата(Знач Сертификат, Знач ДобавкаВремени, Представление) Экспорт
	
	
КонецПроцедуры

Процедура ПриПолученииПредставленияСубъекта(Знач Сертификат, Представление) Экспорт
	
	
КонецПроцедуры

Процедура ПриПолученииРасширенныхСвойствСубъектаСертификата(Знач Субъект, Свойства) Экспорт
	
	
КонецПроцедуры

Процедура ПриПолученииРасширенныхСвойствИздателяСертификата(Знач Издатель, Свойства) Экспорт
	
	
КонецПроцедуры

// Возвращаемое значение:
//  Неопределено, Структура - Данные удостоверяющего центра:
//   * Государственный - Булево
//   * ПериодыДействия - Неопределено, Массив Из Структура:
//   	**ДатаС - Дата
//   	**ДатаПо - Дата, Неопределено
//   * ДатаОкончанияДействия - Неопределено, Дата
//   * ДатаОбновления - Неопределено, Дата
//
Функция ДанныеУдостоверяющегоЦентра(ЗначенияПоиска, АккредитованныеУдостоверяющиеЦентры) Экспорт
	
	Результат = Неопределено;
	
	
	Возврат Результат;
	
КонецФункции


#КонецОбласти