﻿&НаКлиенте
Перем RegExp;

&НаКлиенте
Перем Последовательность;

&НаКлиенте
Перем СтрокаОтбора;
#Область ОбщиеМетоды

// Функция - Добавить значение в массив без повторений
//
// Параметры:
//  Массив	 - Массив - результирующий массив
//  Значение - Произвольное - добавляемое значение
//
&НаКлиентеНаСервереБезКонтекста
Функция ДобавитьВМассивБезПовторений(Массив, Значение)

	Элем = Массив.Найти(Значение);
	Если Элем = Неопределено Тогда
		Массив.Добавить(Значение);
		Возврат Массив.ВГраница();
	Иначе
		Возврат Элем;
	КонецЕсли;

КонецФункции
&НаКлиентеНаСервереБезКонтекста
Функция МассивВСтроку(Массив, Разделитель)

	Стр = "";
	Для Каждого Элем Из Массив Цикл
		Если Не ПустаяСтрока(Стр) Тогда
			Стр = Стр + Разделитель;
		КонецЕсли;
		Стр = Стр + СокрЛП(Элем);
	КонецЦикла;

	Возврат Стр;

КонецФункции
&НаКлиентеНаСервереБезКонтекста
Функция ПовторитьСимвол(Симв, КвоРаз)

	Рез = "";
	Для Инд = 1 По КвоРаз Цикл
		Рез = Рез + Симв;
	КонецЦикла;

	Возврат Рез;

КонецФункции
&НаКлиентеНаСервереБезКонтекста
Функция СтрокаВМассив(Знач Стр, Разделитель)

	сп = Новый Массив;

	ДлинаРазделителя = СтрДлина(Разделитель);
	Если ДлинаРазделителя <> 0 Тогда
		Пока СтрДлина(Стр) > 0 Цикл
			Поз = Найти(Стр, Разделитель);
			Если Поз = 0 Тогда
				сп.Добавить(СокрЛП(Стр));
				Стр="";
			Иначе
				сп.Добавить(СокрЛП(Лев(Стр, Поз - 1)));
				Стр = СокрЛП(Сред(Стр, Поз + ДлинаРазделителя));
			КонецЕсли;
		КонецЦикла;
	Иначе
		ДлинаСтроки = СтрДлина(Стр);
		Для Инд = 1 По ДлинаСтроки Цикл
			сп.Добавить(Сред(Стр, Инд, 1));
		КонецЦикла;
	КонецЕсли;

	Возврат сп;

КонецФункции
&НаКлиентеНаСервереБезКонтекста
Функция СтрокаВСписокЗначений(Знач Стр, Разделитель)

	сп = Новый СписокЗначений;

	ДлинаРазделителя = СтрДлина(Разделитель);
	Если ДлинаРазделителя <> 0 Тогда
		Пока СтрДлина(Стр) > 0 Цикл
			Поз = Найти(Стр, Разделитель);
			Если Поз = 0 Тогда
				сп.Добавить(СокрЛП(Стр));
				Стр="";
			Иначе
				сп.Добавить(СокрЛП(Лев(Стр, Поз - 1)));
				Стр = СокрЛП(Сред(Стр, Поз + ДлинаРазделителя));
			КонецЕсли;
		КонецЦикла;
	Иначе
		ДлинаСтроки = СтрДлина(Стр);
		Для Инд = 1 По ДлинаСтроки Цикл
			сп.Добавить(Сред(Стр, Инд, 1));
		КонецЦикла;
	КонецЕсли;

	Возврат сп;

КонецФункции

#КонецОбласти

&НаСервереБезКонтекста
Функция ЗначениеВСтроку(Значение)

	Возврат ЗначениеВСтрокуВнутр(Значение);

КонецФункции

&НаСервереБезКонтекста
Функция ЗначениеИзСтроки(Значение)

	Возврат ЗначениеИзСтрокиВнутр(Значение);

КонецФункции
&НаСервере
Процедура ПриСозданииНаСервере(Отказ, СтандартнаяОбработка)

	Заголовок = Параметры.Заголовок;
	Выражение = Параметры.Выражение;
	СписокТэгов = Параметры.СписокДляВыбора;
	ЛеваяСкобкаПараметра = Параметры.ЛеваяСкобкаПараметра;
	ПраваяСкобкаПараметра = Параметры.ПраваяСкобкаПараметра;
	ШаблонИмениПараметра = Параметры.ШаблонИмениПараметра;

	Если Не ПустаяСтрока(Параметры.Варианты) Тогда
		Варианты = ЗначениеИзСтроки(Параметры.Варианты);
	КонецЕсли;

	ТолькоПросмотрВыражения = Ложь;
	Если Параметры.Свойство("ТолькоПросмотр") Тогда
		ТолькоПросмотрВыражения = Параметры.ТолькоПросмотр;

		Если ТолькоПросмотрВыражения Тогда
			Элементы.Группа4.Видимость = Ложь;
			Элементы.СписокТэгов.Видимость = Ложь;
			Элементы.ОтборТэгов.Видимость = Ложь;
			Элементы.Группа21.Видимость = Ложь;
			Элементы.ГруппаВарианты.Видимость = Ложь;

		КонецЕсли;
	КонецЕсли;

КонецПроцедуры

&НаКлиенте
Процедура Вариант(Команда)

КонецПроцедуры

&НаКлиенте
Процедура ПриОткрытии(Отказ)

	RegExp = Новый COMОбъект("VBScript.RegExp");

	ПолучитьНажатияКлавиш();
	СтрокаОтбора = "";

	Если ТолькоПросмотрВыражения Тогда
		ОтформатироватьВыражение();
	Иначе
		Элем = СоздатьВариант(Выражение, ТекущаяДата());
	КонецЕсли;

КонецПроцедуры

&НаКлиенте
Функция СоздатьВариант(Знач ТекВыражение, Знач ТекКомментарий)

	ТекФорматирование = ИзвлечьФорматирование(ТекВыражение);

	ТакогоНет = Истина;
	Для Каждого Элем Из Варианты Цикл
		Структура = Элем.Значение;
		Если Структура.Выражение = ТекВыражение Тогда
			ТакогоНет = Ложь;
			Прервать;
		КонецЕсли;
	КонецЦикла;

	Если ТакогоНет Тогда
		Структура = Новый Структура("Выражение,Форматирование,Комментарий", ТекВыражение, ТекФорматирование,
			ТекКомментарий);
		Элем = Варианты.Добавить(Структура, ТекущаяДата(), Истина, БиблиотекаКартинок.Форма);
	КонецЕсли;

	Возврат Элем;

КонецФункции
&НаКлиенте
Функция ПолучитьНажатияКлавиш()

	Последовательность = Новый Структура;
	
	//Позиция курсора помечается символом #
	Последовательность.Вставить("Тэг", ЛеваяСкобкаПараметра + "Шаблон#" + ПраваяСкобкаПараметра);

	Последовательность.Вставить("Вариант", "|");
	Последовательность.Вставить("ВариантБезФиксации", "(?:Шаблон#|)");
	Последовательность.Вставить("ВозвратКаретки", "\r");
	Последовательность.Вставить("ВпередиЕсть", "(?=Шаблон#)");
	Последовательность.Вставить("ВпередиНет", "(?!Шаблон#)");
	Последовательность.Вставить("ГраницаСлова", "\b");
	Последовательность.Вставить("ДиапазонСимволов", "[Шаблон#]");
	Последовательность.Вставить("ДиапазонСимволовОтриц", "[^Шаблон#]");
	Последовательность.Вставить("Идентификатор", "\w");
	Последовательность.Вставить("КонецСтроки", "$");
	Последовательность.Вставить("КруглыеСкобки", "\(Шаблон#\)");
	Последовательность.Вставить("НачалоСтроки", "^");
	Последовательность.Вставить("НеГраницаСлова", "\B");
	Последовательность.Вставить("НеИдентификатор", "\W");
	Последовательность.Вставить("НеПробельныйСимвол", "\S");
	Последовательность.Вставить("НеЦифра", "\D");
	Последовательность.Вставить("ПереводСтроки", "\n");
	Последовательность.Вставить("Повтор01", "?");
	Последовательность.Вставить("ПовторN", "{#}");
	Последовательность.Вставить("ПовторM", "{,#}");
	Последовательность.Вставить("ПовторБольшеN", "{#,}");
	Последовательность.Вставить("ПовторОт0", "*");
	Последовательность.Вставить("ПовторОт0НеЖадный", "*?");
	Последовательность.Вставить("ПовторОт1", "+");
	Последовательность.Вставить("ПовторОт1НеЖадный", "+?");
	Последовательность.Вставить("ПробельныйСимвол", "\s");
	Последовательность.Вставить("СзадиЕсть", "(?<=Шаблон#)");
	Последовательность.Вставить("СзадиНет", "(?<!Шаблон#)");
	Последовательность.Вставить("Табуляция", "\t");
	Последовательность.Вставить("Точка", ".");
	Последовательность.Вставить("ФигурныеСкобки", "\{Шаблон#\}");
	Последовательность.Вставить("Цифра", "\d");
	Последовательность.Вставить("ШаблонНеФикс", "(?:Шаблон#)");
	Последовательность.Вставить("ШаблонФикс", "(Шаблон#)");
	Последовательность.Вставить("Экран", "\");

КонецФункции
&НаКлиенте
Процедура Сформировать(Команда)
	Фокус = Элементы.Выражение;
	ВыделенныйТекст = Фокус.ВыделенныйТекст;
	ТекущаяПоследовательность = СтрЗаменить(Последовательность[Команда.Имя], "Шаблон", ВыделенныйТекст);
	ВключитьСтроку(ТекущаяПоследовательность);

КонецПроцедуры

&НаКлиенте
Процедура ВключитьСтроку(ТекущаяПоследовательность)

	Перем НачСтр, НачКол, КонСтр, КонКол;

	Если ИмеетсяФорматирование(Выражение) Тогда

	КонецЕсли;

	Фокус = Элементы.Выражение;
	Фокус.ПолучитьГраницыВыделения(НачСтр, НачКол, КонСтр, КонКол);
	ЭтаФорма.ТекущийЭлемент = Фокус;
	ВыделенныйТекст = Фокус.ВыделенныйТекст;
	Переформатировать = ИмеетсяФорматирование(ВыделенныйТекст);
	Если Переформатировать Тогда
		ИзвлечьФорматирование(ВыделенныйТекст);
		КонСтр = НачСтр;
		КонКол = НачКол + СтрДлина(ВыделенныйТекст);

		Фокус.ВыделенныйТекст = ВыделенныйТекст;
		Фокус.УстановитьГраницыВыделения(НачСтр, НачКол, КонСтр, КонКол);
	КонецЕсли;

	Поз = Найти(ТекущаяПоследовательность, "#");
	Если Поз = 0 Тогда
		Поз = СтрДлина(ТекущаяПоследовательность);
	Иначе
		ТекущаяПоследовательность = СтрЗаменить(ТекущаяПоследовательность, "#", "");
		Поз = Поз - 1;
	КонецЕсли;
	КонКол = НачКол + Поз;

	Фокус.ВыделенныйТекст = ТекущаяПоследовательность;
	Фокус.УстановитьГраницыВыделения(НачСтр, КонКол, КонСтр, КонКол);
	
	//Если Переформатировать Тогда
	//	ОтформатироватьВыражение();
	//КонецЕсли;

КонецПроцедуры
&НаКлиенте
Процедура ОтправитьПоследовательность()
	
	//НаКлиенте.НажатьКлавишу(ТекущаяПоследовательность);

КонецПроцедуры
&НаКлиенте
Процедура СписокТэговВыбор(Элемент, ВыбраннаяСтрока, Поле, СтандартнаяОбработка)

	ТД = Элементы.СписокТэгов.ТекущиеДанные;
	ВключитьСтроку(ТД.Значение);
	СтандартнаяОбработка = Ложь;

КонецПроцедуры
&НаКлиенте
Процедура Ввести(Команда)

	Перем ПолноеИмяТэга, Значение;

	ВыражениеБезФорматирования = Выражение;
	ИзвлечьФорматирование(ВыражениеБезФорматирования);

	НовыеПараметры = Новый СписокЗначений;
	Для Каждого Парам Из СписокТэгов Цикл
		Если Не Парам.Пометка Тогда
			Продолжить;
		КонецЕсли;

		Разобрать(Парам.Представление, ПолноеИмяТэга, Истина, Значение);
		НовыеПараметры.Добавить(ПолноеИмяТэга, Значение);
	КонецЦикла;
	Результат = Новый Структура;
	Результат.Вставить("Выражение", Выражение);
	Результат.Вставить("НовыеПараметры", НовыеПараметры);
	Для Каждого Вар Из Варианты Цикл
		Если Вар.Картинка = БиблиотекаКартинок.Форма Тогда
			Варианты.Удалить(Вар);
		КонецЕсли;
	КонецЦикла;

	Если Варианты.Количество() <> 0 Тогда
		Результат.Вставить("Варианты", ЗначениеВСтроку(Варианты));
	Иначе
		Результат.Вставить("Варианты", "");
	КонецЕсли;

	Закрыть(Результат);

КонецПроцедуры
&НаКлиенте
Функция ИмеетсяФорматирование(ФорматированнаяСтрока)

	Форматирование = Новый Массив;

	RegExp.Multiline = Ложь;
	RegExp.Global = Истина;
	RegExp.IgnoreCase = Истина;
	RegExp.Pattern = "\t|\n";

	Возврат RegExp.Test (ФорматированнаяСтрока);

КонецФункции
&НаКлиенте
Функция ИзвлечьФорматирование(ФорматированнаяСтрока)

	Перем НачСтр, НачКол, КонСтр, КонКол;
	
	//Фокус = Элементы.Выражение;
	//Фокус.ПолучитьГраницыВыделения(НачСтр, НачКол, КонСтр, КонКол);
	//ВыделенныйТекст = Фокус.ВыделенныйТекст;
	//Если ИмеетсяФорматирование(ВыделенныйТекст) Тогда
	//	
	//КонецЕсли;
	Форматирование = Новый Массив;

	RegExp.Multiline = Ложь;
	RegExp.Global = Истина;
	RegExp.IgnoreCase = Истина;
	RegExp.Pattern = "\t|\n";

	Результат = RegExp.Execute (ФорматированнаяСтрока);
	Для Каждого Стр Из Результат Цикл
		Поз = Стр.FirstIndex;
		Сим = Стр.Value;
		Если Сим = Символы.Таб Тогда
			Форматирование.Добавить(Поз);
		Иначе
			Форматирование.Добавить(-Поз);
		КонецЕсли;
	КонецЦикла;

	ФорматированнаяСтрока = СтрЗаменить(ФорматированнаяСтрока, Символы.Таб, "");
	ФорматированнаяСтрока = СтрЗаменить(ФорматированнаяСтрока, Символы.ПС, "");

	Если Форматирование.Количество() <> 0 Тогда
		Форматирование = МассивВСтроку(Форматирование, ",");
	Иначе
		Форматирование = "";
	КонецЕсли;

	Возврат Форматирование;

КонецФункции
&НаКлиенте
Функция УстановитьФорматирование(Знач ФорматируемаяСтрока, Знач Форматирование)

	Форматирование = СтрокаВМассив(Форматирование, ",");

	Кво = Форматирование.ВГраница();
	Для Инд = 0 По Кво Цикл
		Ф = Число(Форматирование[Инд]);
		Если Ф < 0 Тогда
			Сим = Символы.ПС;
			Ф = -Ф;
		Иначе
			Сим = Символы.Таб;
		КонецЕсли;

		ФорматируемаяСтрока = Лев(ФорматируемаяСтрока, Ф) + Сим + Сред(ФорматируемаяСтрока, Ф + 1);

	КонецЦикла;

	Возврат ФорматируемаяСтрока;

КонецФункции

&НаКлиенте
Процедура ФорматированиеВыкл(Команда)

	ТекФорматирование = ИзвлечьФорматирование(Выражение);
	Если Не ПустаяСтрока(ТекФорматирование) Тогда
		ИзвлеченноеФорматирование = ТекФорматирование;
	КонецЕсли;

КонецПроцедуры

&НаКлиенте
Процедура ФорматированиеВкл(Команда)

	Если Не ПустаяСтрока(ИзвлеченноеФорматирование) Тогда
		Выражение = УстановитьФорматирование(Выражение, ИзвлеченноеФорматирование);
		ИзвлеченноеФорматирование = "";
	КонецЕсли;

КонецПроцедуры

&НаКлиенте
Процедура ВыражениеНачалоВыбора(Элемент, ДанныеВыбора, СтандартнаяОбработка)
	// Вставить содержимое обработчика.
КонецПроцедуры

&НаКлиенте
Процедура Автоформат(Команда)

	ОтформатироватьВыражение();

КонецПроцедуры
&НаКлиенте
Процедура ОтформатироватьВыражение()

	ТекФорматирование = ИзвлечьФорматирование(Выражение);
	ИзвлеченноеФорматирование = "";
	
	//	Выражение = <Выделение групп>
	//
	//	Левая скобка параметра = <
	//	Правая скобка параметра = >
	//	Шаблон имени = [А-ЯA-Z][-_ А-Яа-я0-9A-Za-z]*?
	//
	//	++	<Выделение групп> = ((?:\\\(|\\\))|\(\?:|\(\?=|\(\?!|[()])

	idВыделениеГрупп = "((?:\\\(|\\\))|\(\?:|\(\?=|\(\?!|[()])";
	idPattern = idВыделениеГрупп;

	RegExp = Новый COMОбъект("VBScript.RegExp");

	RegExp.Multiline = Истина;
	RegExp.Global = Истина;
	RegExp.IgnoreCase = Истина;
	RegExp.Pattern = idPattern;

	Результат = RegExp.Replace(Выражение, Символы.ПС + "$1");
	Выражение = "";

	КвоСтр = СтрЧислоСтрок(Результат);
	Выражение = СтрПолучитьСтроку(Результат, 1);

	Сдвиг = 0;
	ОткрытиеСверху = Ложь;

	Для Инд = 2 По КвоСтр Цикл
		ТекСтр = СтрПолучитьСтроку(Результат, Инд);
		Если Лев(ТекСтр, 1) = ")" Или Лев(ТекСтр, 2) = "\)" Тогда
			Сдвиг = Сдвиг - 1;
			Если ОткрытиеСверху Тогда
				Выражение = Выражение + ТекСтр;
				ОткрытиеСверху = Ложь;
			Иначе
				Выражение = Выражение + Символы.ПС + ПовторитьСимвол(Символы.Таб, Сдвиг) + ТекСтр;
			КонецЕсли;
		Иначе
			ОткрытиеСверху = Истина;
			Выражение = Выражение + ?(ПустаяСтрока(Выражение), "", Символы.ПС) + ПовторитьСимвол(Символы.Таб, Сдвиг)
				+ ТекСтр;
			Сдвиг = Сдвиг + 1;
		КонецЕсли;
	КонецЦикла;

КонецПроцедуры
&НаКлиенте
Процедура ВыбратьИмя(Команда)

	ТД = Элементы.СписокТэгов.ТекущиеДанные;
	ВключитьСтроку(ТД.Значение);

КонецПроцедуры

&НаКлиенте
Процедура ВыбратьЗначение(Команда)

	Перем ИмяТэга, Значение;

	Разобрать(Элементы.СписокТэгов.ТекущиеДанные.Представление, ИмяТэга, Истина, Значение);
	ВключитьСтроку(Значение);

КонецПроцедуры

&НаКлиенте
Процедура Тэг(Команда)

	Фокус = Элементы.Выражение;
	ВыделенныйТекст = Фокус.ВыделенныйТекст;
	ТекущаяПоследовательность = СтрЗаменить(Последовательность[Команда.Имя], "Шаблон", ВыделенныйТекст);

	ВключитьСтроку(ТекущаяПоследовательность);

	ТекущийЭлемент = Элементы.ОтборТэгов;

КонецПроцедуры

&НаКлиенте
Процедура ОтборТэговПриИзменении(Элемент)

	Перем НачСтр, НачКол, КонСтр, КонКол;

	ДЛС = СтрДлина(ЛеваяСкобкаПараметра);
	ДПС = СтрДлина(ПраваяСкобкаПараметра);

	ВСкобки = Ложь;
	Фокус = Элементы.Выражение;
	Фокус.ПолучитьГраницыВыделения(НачСтр, НачКол, КонСтр, КонКол);
	Если НачКол - ДЛС > 0 И НачСтр = КонСтр И НачКол = КонКол Тогда
		Фокус.УстановитьГраницыВыделения(НачСтр, НачКол - ДЛС, КонСтр, КонКол + ДПС);
		Текст = Фокус.ВыделенныйТекст;
		Если Текст = ЛеваяСкобкаПараметра + ПраваяСкобкаПараметра Тогда
			ВСкобки = Истина;
		КонецЕсли;

		Фокус.УстановитьГраницыВыделения(НачСтр, НачКол, КонСтр, КонКол);
	КонецЕсли;

	Текст = ОтборТэгов;
	Если Лев(Текст, ДЛС) = ЛеваяСкобкаПараметра Тогда
		Текст = Сред(ОтборТэгов, ДЛС + 1);
	КонецЕсли;
	Если Прав(Текст, ДПС) = ПраваяСкобкаПараметра Тогда
		Текст = Лев(Текст, СтрДлина(Текст) - ДПС);
	КонецЕсли;

	Если ВСкобки Тогда
		Текст = НормализоватьИмя(Текст);
	КонецЕсли;
	Найдено = СписокТэгов.НайтиПоЗначению(ЛеваяСкобкаПараметра + Текст + ПраваяСкобкаПараметра);
	Если Найдено <> Неопределено Тогда
		Элементы.СписокТэгов.ТекущаяСтрока = Найдено.ПолучитьИдентификатор();

		Если Не ВСкобки Тогда
			Если Найти(ВРег(Найдено.Значение), ВРег(СтрокаОтбора)) = 0 Тогда
				Текст = Сред(Найдено.Представление, СтрДлина(Текст) + ДЛС + ДПС + 3);
			Иначе
				Текст = Найдено.Значение;
			КонецЕсли;
		КонецЕсли;
	КонецЕсли;

	ВключитьСтроку(Текст);
	ОтборТэгов = "";

	СтрокаОтбора = "";

	Если ВСкобки Тогда
		Фокус.ПолучитьГраницыВыделения(НачСтр, НачКол, КонСтр, КонКол);
		Фокус.УстановитьГраницыВыделения(НачСтр, НачКол + ДПС, КонСтр, КонКол + ДПС);
	КонецЕсли;
КонецПроцедуры

&НаКлиенте
Процедура ОтборТэговАвтоПодбор(Элемент, Текст, ДанныеВыбора, ПараметрыПолученияДанных, Ожидание, СтандартнаяОбработка)

	Если ПустаяСтрока(Текст) Тогда
		Возврат;
	КонецЕсли;

	СтрокаОтбора = Текст;

	ОбщаяМаска = СтрЗаменить(Текст, "  ", " ");
	ВсеМаски = СтрокаВСписокЗначений(ОбщаяМаска, " ");

	ДанныеВыбора = Новый СписокЗначений;
	ДанныеВыбора.Добавить(Текст);

	RegExp.Multiline = Ложь;
	RegExp.Global = Истина;
	RegExp.IgnoreCase = Истина;

	Попытка
		Позже = Новый Массив;
		Для Каждого ТекВар Из СписокТэгов Цикл

			Включить = Истина;
			Для Каждого Маска Из ВсеМаски Цикл
				RegExp.Pattern = Маска.Значение;

				Если Не RegExp.Test(ТекВар.Значение) Тогда
					Включить = Ложь;
					Прервать;
				КонецЕсли;
			КонецЦикла;

			Если Не Включить Тогда
				ВключитьПозже = Истина;
				Для Каждого Маска Из ВсеМаски Цикл
					RegExp.Pattern = Маска.Значение;

					Если Не RegExp.Test(ТекВар.Представление) Тогда
						ВключитьПозже = Ложь;
						Прервать;
					КонецЕсли;
				КонецЦикла;
			КонецЕсли;

			Если Включить Тогда
				ДанныеВыбора.Добавить(ТекВар.Значение, ТекВар.Представление);
			ИначеЕсли ВключитьПозже Тогда
				ДобавитьВМассивБезПовторений(Позже, ТекВар);
			КонецЕсли;
		КонецЦикла;
		Для Инд = 0 По Позже.ВГраница() Цикл
			ТекВар = Позже[Инд];
			ДанныеВыбора.Добавить(ТекВар.Значение, "•" + ТекВар.Представление);
		КонецЦикла;

	Исключение
		ДанныеВыбора.Очистить();
	КонецПопытки;

	СтандартнаяОбработка = Ложь;

КонецПроцедуры
&НаКлиенте
Процедура ПрисвоитьИмяЗначению(Команда)

	Перем ВремИмяТэга, Значение;

	Фокус = Элементы.Выражение;
	ВыделенныйТекст = Фокус.ВыделенныйТекст;
	ИзвлечьФорматирование(ВыделенныйТекст);
	Если ПустаяСтрока(ВыделенныйТекст) Тогда
		Возврат;
	КонецЕсли;

	ИмяТэга = "";
	Для Каждого Парам Из СписокТэгов Цикл
		Если Парам.Пометка Тогда
			Разобрать(Парам.Представление, ВремИмяТэга, Ложь, Значение);
			Если Значение = ВыделенныйТекст Тогда
				ИмяТэга = ВремИмяТэга;
				Прервать;
			КонецЕсли;
		КонецЕсли;
	КонецЦикла;
	Если ПустаяСтрока(ИмяТэга) Тогда
		ПоказатьВводСтроки(Новый ОписаниеОповещения("ПрисвоитьИмяЗначениюЗавершение", ЭтаФорма,
			Новый Структура("ВремИмяТэга, ВыделенныйТекст, Значение, ИмяТэга", ВремИмяТэга, ВыделенныйТекст, Значение,
			ИмяТэга)), ИмяТэга, ВыделенныйТекст + " - имя?", 0);
		Возврат;
	КонецЕсли;

	ПолноеИмяТэга = ЛеваяСкобкаПараметра + ИмяТэга + ПраваяСкобкаПараметра;
	ВключитьСтроку(ПолноеИмяТэга);
КонецПроцедуры

&НаКлиенте
Процедура ПрисвоитьИмяЗначениюЗавершение(Строка, ДополнительныеПараметры) Экспорт

	ВремИмяТэга = ДополнительныеПараметры.ВремИмяТэга;
	ВыделенныйТекст = ДополнительныеПараметры.ВыделенныйТекст;
	Значение = ДополнительныеПараметры.Значение;
	ИмяТэга = ?(Строка = Неопределено, ДополнительныеПараметры.ИмяТэга, Строка);
	Если Не (Строка <> Неопределено) Тогда
		Возврат;
	КонецЕсли;
	ИмяТэга = НормализоватьИмя(ИмяТэга);

	Для Каждого Парам Из СписокТэгов Цикл
		Разобрать(Парам.Представление, ВремИмяТэга, Ложь, Значение);
		Если ВРег(ИмяТэга) = ВРег(ВремИмяТэга) Тогда
			ПоказатьПредупреждение( , "Такое имя уже существует.");
			Возврат;
		КонецЕсли;
	КонецЦикла;

	ПолноеИмяТэга = ЛеваяСкобкаПараметра + ИмяТэга + ПраваяСкобкаПараметра;
	Представление = ПолноеИмяТэга + " = " + ВыделенныйТекст;
	Парам = СписокТэгов.Добавить(ПолноеИмяТэга, Представление, Истина);

	ВключитьСтроку(ПолноеИмяТэга);

КонецПроцедуры
&НаКлиенте
Функция ПолучитьШаблонПараметра()

	ЛеваяСкобка = СокрЛП(Объект.ЛеваяСкобкаПараметра);
	ПраваяСкобка = СокрЛП(Объект.ПраваяСкобкаПараметра);
	Шаблон = ЛеваяСкобка + СокрЛП(Объект.ШаблонИмениПараметра) + ПраваяСкобка;

	Возврат Шаблон;

КонецФункции
&НаКлиенте
Процедура НайтиИЗаменитьВсеВхождения(ЗаменитьИмяНаЗначение, ЗаменитьЗначениеНаИмя)

	Перем ПолноеИмяТэга, Значение;

	ТД = Элементы.СписокТэгов.ТекущиеДанные;
	Если ТД = Неопределено Тогда
		Возврат;
	КонецЕсли;

	Разобрать(ТД.Представление, ПолноеИмяТэга, Истина, Значение);

	Переформатировать = ИмеетсяФорматирование(Выражение);
	Если Переформатировать Тогда
		ИзвлечьФорматирование(Выражение);
	КонецЕсли;

	Если ЗаменитьИмяНаЗначение Тогда
		Выражение = СтрЗаменить(Выражение, ПолноеИмяТэга, Значение);
	ИначеЕсли ЗаменитьЗначениеНаИмя Тогда
		Выражение = СтрЗаменить(Выражение, Значение, ПолноеИмяТэга);
	КонецЕсли;

	Если Переформатировать Тогда
		ОтформатироватьВыражение();
	КонецЕсли;

КонецПроцедуры
&НаКлиенте
Процедура НайтиИЗаменитьВсеВхожденияИмени(Команда)

	НайтиИЗаменитьВсеВхождения(Истина, Ложь);

КонецПроцедуры
&НаКлиенте
Процедура НайтиИЗаменитьВсеВхожденияЗначения(Команда)

	НайтиИЗаменитьВсеВхождения(Ложь, Истина);

КонецПроцедуры
&НаКлиенте
Процедура Разобрать(Представление, ИмяТэга, Полное = Истина, Значение)

	RegExp.Multiline = Ложь;
	RegExp.Global = Истина;
	RegExp.IgnoreCase = Истина;
	Если Полное Тогда
		RegExp.Pattern = "^(" + ЛеваяСкобкаПараметра + ШаблонИмениПараметра + ПраваяСкобкаПараметра + ") = (.*)$";
	Иначе
		RegExp.Pattern = "^" + ЛеваяСкобкаПараметра + "(" + ШаблонИмениПараметра + ")" + ПраваяСкобкаПараметра
			+ " = (.*)$";
	КонецЕсли;

	ИмяТэга = "";
	Значение = "";
	Результат = RegExp.Execute(Представление);
	Для Каждого Стр Из Результат Цикл
		Значение = Стр.SubMatches(1);
		ИмяТэга = Стр.SubMatches(0);
		Прервать;
	КонецЦикла;

КонецПроцедуры
&НаКлиенте
Процедура ЗаменитьИмяЗначением(Команда)

	Перем Значение;

	ПолноеИмяТэга = КурсорНаИмени();
	Если ПустаяСтрока(ПолноеИмяТэга) Тогда
		Возврат;
	КонецЕсли;

	Парам = СписокТэгов.НайтиПоЗначению(ПолноеИмяТэга);
	Если Парам = Неопределено Тогда
		Возврат;
	КонецЕсли;

	Разобрать(Парам.Представление, ПолноеИмяТэга, Истина, Значение);
	ВключитьСтроку(Значение);

КонецПроцедуры
&НаКлиенте
Функция КурсорНаИмени()

	Перем НачСтр, НачКол, КонСтр, КонКол;

	Фокус = Элементы.Выражение;
	Фокус.ПолучитьГраницыВыделения(НачСтр, НачКол, КонСтр, КонКол);
	Если НачСтр <> КонСтр Тогда
		Возврат "";
	КонецЕсли;
	RegExp.Multiline = Ложь;
	RegExp.Global = Истина;
	RegExp.IgnoreCase = Истина;

	Если НачСтр = КонСтр И НачКол = КонКол Тогда
		//Курсор в имени...
		RegExp.Pattern = ЛеваяСкобкаПараметра + ШаблонИмениПараметра + ПраваяСкобкаПараметра;
		ТекСтр = СтрПолучитьСтроку(Выражение, НачСтр);
		Фокус.УстановитьГраницыВыделения(НачСтр, 1, НачСтр, СтрДлина(ТекСтр) + 1);

		ВыделенныйТекст = Фокус.ВыделенныйТекст;
		Результат = RegExp.Execute(ВыделенныйТекст);
		Для Каждого Стр Из Результат Цикл
			Начало = Стр.FirstIndex;
			Длина = Стр.Length;
			ПолноеИмяТэга = Стр.Value;

			Если НачКол >= Начало + 2 И НачКол <= Начало + Длина Тогда
				Фокус.УстановитьГраницыВыделения(НачСтр, Начало + 1, НачСтр, Начало + Длина + 1);
				Возврат ПолноеИмяТэга;
			КонецЕсли;
		КонецЦикла;

		Возврат "";
	Иначе
		//Выделено имя...
		ПолноеИмяТэга = Фокус.ВыделенныйТекст;

		RegExp.Pattern = "^" + ЛеваяСкобкаПараметра + ШаблонИмениПараметра + ПраваяСкобкаПараметра + "$";
		Если RegExp.Test(ПолноеИмяТэга) Тогда
			Возврат ПолноеИмяТэга;
		Иначе
			Возврат "";
		КонецЕсли;
	КонецЕсли;
КонецФункции

&НаКлиенте
Процедура ВариантыПриАктивизацииСтроки(Элемент)

	ТД = Элементы.Варианты.ТекущиеДанные;
	Если ТД = Неопределено Тогда
		Возврат;
	КонецЕсли;

	Элементы.ЗапомнитьВариантВыражения.Картинка = ТД.Картинка;
	Структура = ТД.Значение;
	ТекущееВыражение = Структура.Выражение;
	ТекущееФорматирование = Структура.Форматирование;
	ТекущийКомментарий = Структура.Комментарий;

	ТекущееВыражение = УстановитьФорматирование(ТекущееВыражение, ТекущееФорматирование);

КонецПроцедуры

&НаКлиенте
Процедура ЗапомнитьВариантВыражения(Команда)

	Если Элементы.ЗапомнитьВариантВыражения.Картинка = БиблиотекаКартинок.ХранилищеНастроек Тогда
		Элементы.ЗапомнитьВариантВыражения.Картинка = БиблиотекаКартинок.Форма;
	Иначе
		Элементы.ЗапомнитьВариантВыражения.Картинка = БиблиотекаКартинок.ХранилищеНастроек;
	КонецЕсли;

	Элем = Варианты.НайтиПоИдентификатору(Элементы.Варианты.ТекущаяСтрока);
	Элем.Картинка = Элементы.ЗапомнитьВариантВыражения.Картинка;

КонецПроцедуры

&НаКлиенте
Процедура ВариантыВыбор(Элемент, ВыбраннаяСтрока, Поле, СтандартнаяОбработка)

	ВыбратьЭтотВариант();

КонецПроцедуры
&НаКлиенте
Процедура ВыбратьЭтотВариант()

	ТД = Элементы.Варианты.ТекущиеДанные;
	Если ТД = Неопределено Тогда
		Возврат;
	КонецЕсли;

	Структура = ТД.Значение;

	Выражение = Структура.Выражение;
	Выражение = УстановитьФорматирование(Выражение, Структура.Форматирование);
	ТекущийЭлемент = Элементы.ГруппаРедактор;

КонецПроцедуры
&НаКлиенте
Процедура Группа1ПриСменеСтраницы(Элемент, ТекущаяСтраница)

	Если ТекущаяСтраница = Элементы.ГруппаВарианты Тогда
		Элем = СоздатьВариант(Выражение, ТекущаяДата());
		Элементы.Варианты.ТекущаяСтрока = Элем.ПолучитьИдентификатор();
	КонецЕсли;

КонецПроцедуры
&НаКлиенте
Процедура ТекущийвариантКомментарийПриИзменении(Элемент)

	ТД = Элементы.Варианты.ТекущиеДанные;
	Если ТД = Неопределено Тогда
		Возврат;
	КонецЕсли;

	Структура = ТД.Значение;
	Структура.Комментарий = ТекущийКомментарий;

КонецПроцедуры
&НаКлиенте
Процедура ВариантыВыборЗначения(Элемент, Значение, СтандартнаяОбработка)

	ВыбратьЭтотВариант();

КонецПроцедуры

// Функция - Нормализовать имя параметра. Удаляются концевые пробелы, несколько последовательных пробелов заменяются одним
//
// Параметры:
//  Имя	 - Строка	 - имя параметра
// 
// Возвращаемое значение:
// Строка  - нормализованное имя параметра
//
&НаКлиенте
Функция НормализоватьИмя(Знач Имя)

	RegExp.Multiline = Ложь;
	RegExp.Global = Истина;
	RegExp.IgnoreCase = Ложь;
	RegExp.Pattern = "( +)";

	Имя = RegExp.Replace (Имя, " ");

	Возврат СокрЛП(Имя);

КонецФункции