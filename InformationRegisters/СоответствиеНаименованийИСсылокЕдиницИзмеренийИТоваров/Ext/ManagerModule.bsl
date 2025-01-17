﻿// Функция получает элемент справочника - ключ аналитики учета.
//
// Параметры:
//	ПараметрыСоответствия - Выборка или Структура  с полями "Контрагент, КлючАналитики, Товар, ЕдиницаИзмерения, КоэффициентПересчета".
//
//
Процедура СоздатьЗаписьСоответствия(ПараметрыСоответствия) Экспорт
				
	Если ЗначениеЗаполнено(ПараметрыСоответствия.Контрагент)
		И ТипЗнч(ПараметрыСоответствия.Контрагент) = Тип("СправочникСсылка.Контрагенты") 
		И ЗначениеЗаполнено(ПараметрыСоответствия.КлючАналитикиСоответствия)
		И (ЗначениеЗаполнено(ПараметрыСоответствия.Товар) 
		ИЛИ ЗначениеЗаполнено(ПараметрыСоответствия.ЕдиницаИзмерения)) Тогда
		
				
		МенеджерЗаписи = РегистрыСведений.СоответствиеНаименованийИСсылокЕдиницИзмеренийИТоваров.СоздатьМенеджерЗаписи();
		ЗаполнитьЗначенияСвойств(МенеджерЗаписи, ПараметрыСоответствия);
		Если ПараметрыСоответствия.КоэффициентПересчета = 0 Тогда
			МенеджерЗаписи.КоэффициентПересчета = 1;
		КонецЕсли;
      
		МенеджерЗаписи.Записать(Истина);					
		
	КонецЕсли;
		
КонецПроцедуры

