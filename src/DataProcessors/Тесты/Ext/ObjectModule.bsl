﻿#Если Сервер Или ТолстыйКлиентОбычноеПриложение Или ВнешнееСоединение Тогда

Процедура Тест_()
	
	Сессия = КоннекторHTTP.СоздатьСессию();
	Ответ = КоннекторHTTP.ВызватьМетодВСеансе(Сессия, "GET", "https://ya.ru", Новый Структура("ПроверятьSSL", Ложь));
	Ответ = КоннекторHTTP.ВызватьМетодВСеансе(Сессия, "GET", "https://ya.ru");
	
КонецПроцедуры

Процедура ВыполнитьТестыНаСервере() Экспорт
	
	Тест_();
	//Тест_ПередачаПараметровВСтрокуЗапроса();
	//Тест_ПередачаПараметровВСтрокуЗапросаКомбинированный();
	//
	//Тест_РезультатКакJsonGet();
	//Тест_РезультатКакJsonPost();
	//Тест_РезультатКакДвоичныеДанные();
	//Тест_РезультатКакТекст();
	//
	//Тест_ПередачаПроизвольныхЗаголовков();
	//
	//Тест_ОтправкаДанныхФормы();
	//Тест_ОтправкаJson();
	//
	////Тест_СоединениеЧерезПрокси();
	//
	//Тест_GetJson();
	//Тест_PostJson();
	//Тест_GetJsonСтруктура();
	//Тест_PutJson();
	//Тест_DeleteJson();
	//
	//Тест_BasicAuth();
	//Тест_DigestAuth();
	//
	//Тест_ПолучитьGZip();
	//
	//
	//Тест_GetУспешнийРедиректОтносительныйАдрес();
	//Тест_GetУспешнийРедиректАбсолютныйАдрес();
	//Тест_GetЗацикленныйРедирект();
	//Тест_GetОтключенныйРедирект();
	//
	//Тест_Options();
	//Тест_Head();
	//Тест_PutПараметры();
	//Тест_Delete();
	//Тест_Patch();
	////Тест_PostПараметры();
	//
	//Тест_Ошибка404();

	//Тест_POST_MultipartFormData();
	//
	//Тест_Таймаут();
	//
	Тест_ОтправитьCookies();
	
	//Тест_Session();
	Тест_SetCookies();
	
КонецПроцедуры

#Область Тесты

Процедура Тест_ПолучитьGZip()
	
	Результат = КоннекторHTTP.GetJson("http://httpbin.org/gzip");
	УтверждениеВерно(Результат["gzipped"], Истина);
	
КонецПроцедуры
	
Процедура Тест_BasicAuth()
	
	Результат = КоннекторHTTP.GetJson("https://user:pass@httpbin.org/basic-auth/user/pass");
	УтверждениеВерно(Результат["authenticated"], Истина);
	УтверждениеВерно(Результат["user"], "user");

	Аутентификация = Новый Структура("Пользователь, Пароль", "user", "pass");
	Результат = КоннекторHTTP.GetJson(
		"https://httpbin.org/basic-auth/user/pass",,
		Новый Структура("Аутентификация", Аутентификация));
	УтверждениеВерно(Результат["authenticated"], Истина);
	УтверждениеВерно(Результат["user"], "user");

	Аутентификация = Новый Структура("Пользователь, Пароль, Тип", "user", "pass", "Basic");
	Результат = КоннекторHTTP.GetJson(
		"https://httpbin.org/basic-auth/user/pass",,
		Новый Структура("Аутентификация", Аутентификация));
	УтверждениеВерно(Результат["authenticated"], Истина);
	УтверждениеВерно(Результат["user"], "user");

КонецПроцедуры

Процедура Тест_DigestAuth()
			
	Аутентификация = Новый Структура("Пользователь, Пароль, Тип", "user", "pass", "Digest");
	Результат = КоннекторHTTP.GetJson(
		"https://httpbin.org/digest-auth/auth/user/pass",,
		Новый Структура("Аутентификация", Аутентификация));

КонецПроцедуры
	
Процедура Тест_GetJson()
	
	Результат = КоннекторHTTP.GetJson("http://httpbin.org/get");
	УтверждениеВерно(Результат["url"], "http://httpbin.org/get");
	
КонецПроцедуры

Процедура Тест_GetJsonСтруктура()
	
	ПараметрыПреобразованияJSON = Новый Структура("ПрочитатьВСоответствие", Ложь);
	Результат = КоннекторHTTP.GetJson("http://httpbin.org/json",, Новый Структура("ПараметрыПреобразованияJSON", ПараметрыПреобразованияJSON));
	УтверждениеВерно(Результат.slideshow.author, "Yours Truly");
	УтверждениеВерно(Результат.slideshow.date, "date of publication");
	УтверждениеВерно(Результат.slideshow.slides.Количество(), 2);
	УтверждениеВерно(Результат.slideshow.title, "Sample Slide Show");
	
КонецПроцедуры

Процедура Тест_PostJson()
	
	ПараметрыПреобразованияJSON = Новый Структура;
	ПараметрыПреобразованияJSON.Вставить("ИменаСвойствСоЗначениямиДата", "Дата");
	
	Json = Новый Структура;
	Json.Вставить("Дата", '20190121002400');
	Json.Вставить("Число", 5);
	Json.Вставить("Булево", True);
	Json.Вставить("Строка", "Привет");
		
	Результат = КоннекторHTTP.PostJson(
		"http://httpbin.org/post", 
		Json, 
		Новый Структура("ПараметрыПреобразованияJSON", ПараметрыПреобразованияJSON));
	УтверждениеВерно(Результат["url"], "http://httpbin.org/post");
	УтверждениеВерно(Результат["json"]["Дата"], '20190121002400');
	УтверждениеВерно(Результат["json"]["Число"], 5);
	УтверждениеВерно(Результат["json"]["Булево"], True);
	УтверждениеВерно(Результат["json"]["Строка"], "Привет");

КонецПроцедуры

Процедура Тест_PutJson()
	
	Результат = КоннекторHTTP.PutJson("http://httpbin.org/put", Новый Структура("Название", "КоннекторHTTP"));
	УтверждениеВерно(Результат["url"], "http://httpbin.org/put");
	УтверждениеВерно(Результат["json"]["Название"], "КоннекторHTTP");
	
КонецПроцедуры

Процедура Тест_DeleteJson()
	
	Результат = КоннекторHTTP.DeleteJson("http://httpbin.org/delete", Новый Структура("Название", "КоннекторHTTP"));
	УтверждениеВерно(Результат["url"], "http://httpbin.org/delete");
	УтверждениеВерно(Результат["json"]["Название"], "КоннекторHTTP");
	
КонецПроцедуры


Процедура Тест_ПередачаПараметровВСтрокуЗапроса()
	
	ПараметрыЗапроса = Новый Структура;
	ПараметрыЗапроса.Вставить("name", СтрРазделить("Иванов,Петров", ","));
	ПараметрыЗапроса.Вставить("salary", Формат(100000, "ЧГ="));
	
	Ответ = КоннекторHTTP.Get("https://httpbin.org/anything/params", ПараметрыЗапроса);	
	Результат = КоннекторHTTP.КакJson(Ответ);
	
	УтверждениеВерно(Ответ.URL, "https://httpbin.org/anything/params?name=%D0%98%D0%B2%D0%B0%D0%BD%D0%BE%D0%B2&name=%D0%9F%D0%B5%D1%82%D1%80%D0%BE%D0%B2&salary=100000");
	УтверждениеВерно(Результат["url"], "https://httpbin.org/anything/params?name=Иванов&name=Петров&salary=100000");
	УтверждениеВерно(Результат["args"]["salary"], "100000");
	УтверждениеВерно(СтрСоединить(Результат["args"]["name"], ","), "Иванов,Петров");
	
КонецПроцедуры

Процедура Тест_ПередачаПараметровВСтрокуЗапросаКомбинированный()
	
	ПараметрыЗапроса = Новый Структура;
	ПараметрыЗапроса.Вставить("name", СтрРазделить("Иванов,Петров", ","));
	ПараметрыЗапроса.Вставить("salary", Формат(100000, "ЧГ="));
	
	Результат = КоннекторHTTP.GetJson("https://httpbin.org/anything/params?post=Программист", ПараметрыЗапроса);	
	
	УтверждениеВерно(Результат["args"]["salary"], "100000");
	УтверждениеВерно(Результат["args"]["post"], "Программист");
	УтверждениеВерно(СтрСоединить(Результат["args"]["name"], ","), "Иванов,Петров");
	
КонецПроцедуры

Процедура Тест_РезультатКакJsonGet()
	
	Результат = КоннекторHTTP.GetJson("http://httpbin.org/get");
	УтверждениеВерно(Результат["url"], "http://httpbin.org/get");
	
КонецПроцедуры

Процедура Тест_РезультатКакJsonPost()
	
	Результат = КоннекторHTTP.КакJson(КоннекторHTTP.Post(("http://httpbin.org/post")));
	УтверждениеВерно(Результат["url"], "http://httpbin.org/post");
	
КонецПроцедуры

Процедура Тест_РезультатКакДвоичныеДанные()
	
	Результат = КоннекторHTTP.КакДвоичныеДанные(КоннекторHTTP.Get("http://httpbin.org/image/png"));
	
	УтверждениеВерно(ТипЗнч(Результат), Тип("ДвоичныеДанные"));
	УтверждениеВерно(ПосчитатьMD5(Результат), "5cca6069f68fbf739fce37e0963f21e7");
	
КонецПроцедуры

Процедура Тест_РезультатКакТекст()
	
	Результат = КоннекторHTTP.КакТекст(КоннекторHTTP.Get("http://httpbin.org/encoding/utf8"));
	УтверждениеВерно(СтрНайти(Результат, "Зарегистрируйтесь сейчас на Десятую Международную"), 3931);
	
КонецПроцедуры

Процедура Тест_ПередачаПроизвольныхЗаголовков()
	
	Заголовки = Новый Соответствие;
	Заголовки.Вставить("X-My-Header", "Hello!!!");
	Результат = КоннекторHTTP.GetJson("http://httpbin.org/headers",, Новый Структура("Заголовки", Заголовки));
	
	УтверждениеВерно(Результат["headers"]["X-My-Header"], "Hello!!!");
	
КонецПроцедуры

Процедура Тест_ОтправкаДанныхФормы()
	
	Данные = Новый Структура;
	Данные.Вставить("comments", "Постучать в дверь");
	Данные.Вставить("custemail", "vasya@mail.ru");
	Данные.Вставить("custname", "Вася");
	Данные.Вставить("custtel", "112");
	Данные.Вставить("delivery", "20:20");
	Данные.Вставить("size", "medium");
	Данные.Вставить("topping", СтрРазделить("bacon,mushroom", ","));
	
	Ответ = КоннекторHTTP.Post("http://httpbin.org/post", Данные);
	УтверждениеВерно(Ответ.URL, "http://httpbin.org/post");
	Результат = КоннекторHTTP.КакJson(Ответ);
	УтверждениеВерно(Результат["form"]["size"], "medium");
	УтверждениеВерно(Результат["form"]["comments"], "Постучать в дверь");
	УтверждениеВерно(Результат["form"]["custemail"], "vasya@mail.ru");
	УтверждениеВерно(Результат["form"]["delivery"], "20:20");
	УтверждениеВерно(Результат["form"]["custtel"], "112");	
	УтверждениеВерно(Ответ.Запрос.Заголовки.Получить("Content-Type"), "application/x-www-form-urlencoded");	

КонецПроцедуры

Процедура Тест_ОтправкаJson()
	
	Json = Новый Структура;
	Json.Вставить("Сотрудник", "Иванов Иван Петрович");
	Json.Вставить("Должность", "Разнорабочий");
	
	Результат = КоннекторHTTP.PostJson("http://httpbin.org/post", Json);
	УтверждениеВерно(Результат["json"]["Сотрудник"], "Иванов Иван Петрович");
	УтверждениеВерно(Результат["json"]["Должность"], "Разнорабочий");
	
	Результат = КоннекторHTTP.PutJson("http://httpbin.org/put", Json);
	УтверждениеВерно(Результат["json"]["Сотрудник"], "Иванов Иван Петрович");
	УтверждениеВерно(Результат["json"]["Должность"], "Разнорабочий");
	
КонецПроцедуры



Процедура Тест_GetУспешнийРедиректОтносительныйАдрес()
	
	Ответ = КоннекторHTTP.Get("http://httpbin.org/relative-redirect/6");
	Результат = КоннекторHTTP.КакJson(Ответ);
	
	УтверждениеВерно(Ответ.КодСостояния, 200);
	УтверждениеВерно(Результат["url"], "http://httpbin.org/get");
	
КонецПроцедуры

Процедура Тест_GetУспешнийРедиректАбсолютныйАдрес()
	
	Ответ = КоннекторHTTP.Get("http://httpbin.org/absolute-redirect/6");
	Результат = КоннекторHTTP.КакJson(Ответ);
	
	УтверждениеВерно(Ответ.КодСостояния, 200);
	УтверждениеВерно(Результат["url"], "http://httpbin.org/get");
	
КонецПроцедуры

Процедура Тест_GetЗацикленныйРедирект()
	
	Попытка
		Результат = КоннекторHTTP.КакJson(КоннекторHTTP.Get("http://httpbin.org/redirect/31"));
	Исключение
		ВерноеИсключение(ИнформацияОбОшибке(), "СлишкомМногоПеренаправлений");
	КонецПопытки;
	
КонецПроцедуры

Процедура Тест_GetОтключенныйРедирект()
	
	Параметры = Новый Структура("РазрешитьПеренаправление", Ложь);	
	Ответ = КоннекторHTTP.Get("http://httpbin.org/redirect-to?url=http%3A%2F%2Fhttpbin.org%2Fget&status_code=307",, Параметры);
	
	УтверждениеВерно(Ответ.КодСостояния, 307);
	
КонецПроцедуры

Процедура Тест_Options()
	
	Ответ = КоннекторHTTP.Options("http://httpbin.org/anything");
	
	УтверждениеВерно(Ответ.КодСостояния, 200);
	
КонецПроцедуры

Процедура Тест_Head()
	
	Ответ = КоннекторHTTP.Head("http://httpbin.org/anything");
	
	УтверждениеВерно(Ответ.КодСостояния, 200);
	
КонецПроцедуры

Процедура Тест_Delete()
	
	Ответ = КоннекторHTTP.Delete("http://httpbin.org/delete");
	
	УтверждениеВерно(Ответ.КодСостояния, 200);
	
КонецПроцедуры

Процедура Тест_Patch()
	
	Ответ = КоннекторHTTP.Patch("http://httpbin.org/patch");
	
	УтверждениеВерно(Ответ.КодСостояния, 200);
	
КонецПроцедуры

Процедура Тест_PutПараметры()
	
	Ответ = КоннекторHTTP.Put("http://httpbin.org/put",, Новый Структура("ПараметрыЗапроса", Новый Структура("key1, key2", "value1", "значение2")));
	Результат = КоннекторHTTP.КакJson(Ответ);
	
	УтверждениеВерно(Ответ.КодСостояния, 200);
	УтверждениеВерно(Ответ.URL, "http://httpbin.org/put?key1=value1&key2=%D0%B7%D0%BD%D0%B0%D1%87%D0%B5%D0%BD%D0%B8%D0%B52");
	
КонецПроцедуры

Процедура Тест_Ошибка404()
	
	Ответ = КоннекторHTTP.Get("http://httpbin.org/status/404");
	
	УтверждениеВерно(Ответ.КодСостояния, 404);
	
КонецПроцедуры


Процедура Тест_POST_MultipartFormData()
	
	
	Файлы = Новый Структура;
	Файлы.Вставить("Имя", "test.txt");
	Файлы.Вставить("Файл", );
	Файлы.Вставить("Тип", );
	Файлы.Вставить("Заголовки", );
	
	//TODO:	
	//	>>> url = 'https://httpbin.org/post'
	//>>> multiple_files = [
	//        ('images', ('foo.png', open('foo.png', 'rb'), 'image/png')),
	//        ('images', ('bar.png', open('bar.png', 'rb'), 'image/png'))]
	//>>> r = requests.post(url, files=multiple_files)
	//>>> r.text
	//{
	//  ...
	//  'files': {'images': 'data:image/png;base64,iVBORw ....'}
	//  'Content-Type': 'multipart/form-data; boundary=3131623adb2043caaeb5538cc7aa0b3a',
	//  ...
	//}
	
	
	
	Ответ = КоннекторHTTP.КакJson(КоннекторHTTP.Get("http://httpbin.org/gzip"));
	
	Заголовки = Новый Соответствие;
	Заголовки.Вставить("Accept-Encoding", "gzip");
	Ответ = 
	КоннекторHTTP.Get(
	"https://raw.githubusercontent.com/dscape/spell/master/test/resources/big.txt", 
	,
	Новый Структура("Заголовки", Заголовки));
	
	
	
КонецПроцедуры

Процедура Тест_Таймаут()
	
	Попытка
		Ответ = КоннекторHTTP.Get("https://httpbin.org/delay/10",, Новый Структура("Таймаут", 1));
	Исключение
		ВерноеИсключение(ИнформацияОбОшибке(), "Превышено время ожидания");
	КонецПопытки;
	
КонецПроцедуры

Процедура Тест_ОтправитьCookies()
	
	Cookies = Новый Массив;
	Cookies.Добавить(Новый Структура("Наименование,Значение", "k1", Строка(Новый УникальныйИдентификатор)));
	Cookies.Добавить(Новый Структура("Наименование,Значение", "k2", Строка(Новый УникальныйИдентификатор)));
	Ответ = КоннекторHTTP.Get("http://httpbin.org/cookies",, Новый Структура("Cookies", Cookies));
	Результат = КоннекторHTTP.КакJson(Ответ);
	
	УтверждениеВерно(Результат["k1"], Cookies["k1"]);
	УтверждениеВерно(Результат["k2"], Cookies["k2"]);
	
КонецПроцедуры

Процедура Тест_Session()
	
	Сеанс = КоннекторHTTP.СоздатьСессию();
	Ответ = КоннекторHTTP.ВызватьМетодВСеансе(Сеанс, "GET", "https://releases.1c.ru/total");
	
	Данные = Новый Структура;
	Данные.Вставить("execution", ИзвлечьExecution(Ответ));
	Данные.Вставить("username", Константы.Логин.Получить()); 	
	Данные.Вставить("password", Константы.Пароль.Получить());
	Данные.Вставить("_eventId", "submit");
	Данные.Вставить("geolocation", "");
	Данные.Вставить("submit", "Войти");
	Данные.Вставить("rememberMe", "on");
	
	Ответ = КоннекторHTTP.ВызватьМетодВСеансе(Сеанс, "POST", Ответ.URL, Новый Структура("Данные", Данные));
	
КонецПроцедуры

Процедура Тест_SetCookies()
	
	Ответ = КоннекторHTTP.Get("http://httpbin.org/cookies/set?k2=v2&k1=v1");
	
КонецПроцедуры

Процедура Тест_СоединениеЧерезПрокси()
	
	Прокси = Новый ИнтернетПрокси;
	Прокси.Установить("http", "192.168.1.51", 8192);
	КоннекторHTTP.GetJson("http://httpbin.org/headers",, Новый Структура("Прокси", Прокси));
	
КонецПроцедуры

#КонецОбласти

#Область СлужебныеПроцедурыИФункции

Функция ИзвлечьExecution(Ответ)
	
	// TODO: Доделать
	//def extract_execution(r):
	//if r.status_code == 200:
	//    html = r.text
	//    i = html.find('name="execution"')
	//    if i > 0:
	//        j = html.find('>', i)
	//    new_str = html[i:j]
	//    b = new_str.find('value="') + len('value="')
	//    e = new_str.find('"', b)
	
	//    execution = new_str[b:e]
	//return execution
	//
КонецФункции

Функция ПосчитатьMD5(Данные)
	
	Хеширование = Новый ХешированиеДанных(ХешФункция.MD5);
	Хеширование.Добавить(Данные);
	
	Возврат НРег(ПолучитьHexСтрокуИзДвоичныхДанных(Хеширование.ХешСумма));
	
КонецФункции

Процедура УтверждениеВерно(ЛевоеЗначение, ПравоеЗначение, Пояснение = "")
	
	Если ЛевоеЗначение <> ПравоеЗначение Тогда
		ВызватьИсключение(СтрШаблон("<%1> не равно <%2>: %3", ЛевоеЗначение, ПравоеЗначение, Пояснение));
	КонецЕсли;
	
КонецПроцедуры

Процедура ВерноеИсключение(ИнформацияОбОшибке, ОжидаемоеИсключение)
	
	Если Не СтрНайти(ПодробноеПредставлениеОшибки(ИнформацияОбОшибке), ОжидаемоеИсключение) Тогда
		ВызватьИсключение(ПодробноеПредставлениеОшибки(ИнформацияОбОшибке));
	КонецЕсли;
	
КонецПроцедуры

#КонецОбласти

#КонецЕсли