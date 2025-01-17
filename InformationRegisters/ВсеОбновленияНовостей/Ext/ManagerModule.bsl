﻿///////////////////////////////////////////////////////////////////////////////////////////////////////
// Copyright (c) 2020, ООО 1С-Софт
// Все права защищены. Эта программа и сопроводительные материалы предоставляются 
// в соответствии с условиями лицензии Attribution 4.0 International (CC BY 4.0)
// Текст лицензии доступен по ссылке:
// https://creativecommons.org/licenses/by/4.0/legalcode
///////////////////////////////////////////////////////////////////////////////////////////////////////

#Если Сервер Или ТолстыйКлиентОбычноеПриложение Или ВнешнееСоединение Тогда

#Область СлужебныеПроцедурыИФункции

// Возвращает список доступных значений для поля "ВидОбновления".
//
// Возвращаемое значение:
//   Массив из Строка - список доступных значений.
//
Функция ПолучитьЗначенияДопустимыхВидовОбновления() Экспорт

	Результат = Новый Массив;
		Результат.Добавить("Получение новостей");
		Результат.Добавить("Обновление классификаторов");
		Результат.Добавить("Автоудаление новостей");
		Результат.Добавить("Обновление периодических свойств");
		Результат.Добавить("Обновление привязок к метаданным");
		Результат.Добавить("Проверка версии платформы");

	Возврат Результат;

КонецФункции

#КонецОбласти

#КонецЕсли