﻿Процедура ЗагрузитьВопросы(АдресФайлаВоВременномХранилище) Экспорт
	
	ПутьКФайлу = ПолучитьИмяВременногоФайла("xml");
	
	ДанныеИзХранилища = ПолучитьИзВременногоХранилища(АдресФайлаВоВременномХранилище);
	Если ТипЗнч(ДанныеИзХранилища) = Тип("ДвоичныеДанные") Тогда

		ДанныеИзХранилища.Записать(ПутьКФайлу);
		
	Иначе
		
		Возврат;
		
	КонецЕсли;
	
	Обработка = Обработки.УИ_ВыгрузкаЗагрузкаДанныхXMLСФильтрами.Создать();
	Обработка.ВыполнитьЗагрузку(ПутьКФайлу);
	
	Попытка
		
		УдалитьФайлы(ПутьКФайлу);
		
	Исключение
	КонецПопытки;
	
КонецПроцедуры

Функция ПолучитьВыгрузкуВопросов() Экспорт

	ПутьКФайлу = ПолучитьИмяВременногоФайла("xml");
	
	Обработка = Обработки.УИ_ВыгрузкаЗагрузкаДанныхXMLСФильтрами.Создать();
	Обработка.Инициализация();
	Обработка.ДеревоМетаданных.Строки[0].Строки.Найти("Справочники").Строки.Найти("ИТК_Задачи").Выгружать = 1;
	Обработка.ВыполнитьВыгрузку(ПутьКФайлу, , Новый ТаблицаЗначений);
	
	ДД = Новый ДвоичныеДанные(ПутьКФайлу);
	Адрес = ПоместитьВоВременноеХранилище(ДД);
	
	Возврат Адрес;
		
КонецФункции