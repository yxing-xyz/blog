---
title: "JavaScript Prototype"
date: 2019-10-16T20:39:00+08:00
description: "JavaScript Prototype"
lead: "JavaScript Prototyp" # 导读
thumbnail: "/img/js_prototype.png" # Thumbnail image
categories:
  - "Programming "
tags:
  - "JavaScript"
authorbox: true
pager: true
toc: true
mathjax: true
comments: false
draft: false
---

## 继承
### 实现方法一

**缺点：调用两次父类构造函数，性能开销**

```js
function Person(name, age) {
  (this.name = name), (this.age = age);
  this.setAge = function () {};
}
Person.prototype.setAge = function () {
  console.log("111");
};
Person.test = () => {
  console.log("test");
};
function Student(name, age, price) {
  Person.call(this, name, age);
  this.price = price;
  this.setScore = function () {};
}
Student.prototype = new Person();
Student.prototype.constructor = Student; //组合继承也是需要修复构造函数指向的
Student.prototype.sayHello = function () {};
var s1 = new Student("Tom", 20, 15000);
var p1 = new Person("Jack", 22);
console.log(s1);
console.log(s1.constructor); //Student
console.log(p1.test); //Perso
```

### 实现方法二

**缺点：没办法通过 instance of 区分父子对象，因为父子构造函数 prototype 都指向同一个**

```js
function Person(name, age) {
  (this.name = name), (this.age = age);
  this.setAge = function () {};
}
Person.prototype.setAge = function () {
  console.log("111");
};
function Student(name, age, price) {
  Person.call(this, name, age);
  this.price = price;
  this.setScore = function () {};
}
Student.prototype = Person.prototype;
Student.prototype.sayHello = function () {};
var s1 = new Student("Tom", 20, 15000);
console.log(s1);
```

### 实现方法三

**es5 语法完美继承：能区分父子对象**

```js
function Person(name, age) {
  (this.name = name), (this.age = age);
}
Person.prototype.setAge = function () {
  console.log("111");
};
function Student(name, age, price) {
  Person.call(this, name, age);
  this.price = price;
  this.setScore = function () {};
}
Student.prototype = Object.create(Person.prototype); //核心代码
Student.prototype.constructor = Student; //核心代码
var s1 = new Student("Tom", 20, 15000);
console.log(s1 instanceof Student, s1 instanceof Person); // true true
console.log(s1.constructor); //Student
console.log(s1);
```

### 实现方法四

**es6 语法糖本质还是原型链**

```js
class Person {
  //调用类的构造方法
  constructor(name, age) {
    this.name = name;
    this.age = age;
  }
  //定义一般的方法
  showName() {
    console.log("调用父类的方法");
    console.log(this.name, this.age);
  }
}
let p1 = new Person("kobe", 39);
console.log(p1);
//定义一个子类
class Student extends Person {
  constructor(name, age, salary) {
    super(name, age); //通过super调用父类的构造方法
    this.salary = salary;
  }
  showName() {
    //在子类自身定义方法
    console.log("调用子类的方法");
    console.log(this.name, this.age, this.salary);
  }
}
let s1 = new Student("wade", 38, 1000000000);
console.log(s1);
s1.showName();
```
