﻿
&НаСервере
Процедура ПриСозданииНаСервере(Отказ, СтандартнаяОбработка)

	// В параметрах списка настроен отбор по некоторым видам налога.
	// Если данный отбор не удалить, то при открытии данной формы, 
	// из справочника НалогиСборыОтчисления, будет модульная ошибка.
	
	Если Параметры.Отбор.Свойство("ВидНалога") Тогда		
		ОбщегоНазначенияКлиентСервер.УдалитьЭлементыГруппыОтбора(Список.КомпоновщикНастроек.Настройки.Отбор, "ВидНалога");		
	КонецЕсли;
	
КонецПроцедуры