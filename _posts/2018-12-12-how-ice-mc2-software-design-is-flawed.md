---
layout: post
title: >
    How I Redesigned IFCAT
date: 2018-12-12 10:22:00 -0400
tags: software-design draft
category: random
---

A good piece of code should look clean, concise and does what it is supposed to do.

I am not an expert in software engineering, but during my time contributing to IFCAT project, I did find some design flaws, and this is how I fixed them.

This post mainly serves as my personal reference in the future when I try to code Node.js systems. But also is a good read for anyone who is new to programming.

<!--more-->

## Controllers

In the original code, controllers are single JavaScript files that use `module.exports` to export simple functions.

```javascript
// Save groups for tutorial
exports.saveGroups = (req, res, next) => {
    // Logic here
}
```

This is all good and functional, but what if I need to store state variables? Say I need to keep track of how many users are logged in. It is impossible to do so without another program such as Redis.

I decided to create a Controller super-class that exposes a `getInstance()` static method (yes in JavaScript static methods gets inherited), so I can have all controllers as singletons.

```javascript
class StudentController extends Controller {
    async getStudent(req, res, next) {
        // Do stuff here.
    }
}
```

Now I can do cool stuff like this:

```javascript
const studentController = StudentController.getInstance();
await studentController.getStudent();
```

Which is much more readable and robust.

## Routers

Old code routing files contained actual controller and middleware logic, which is a big no-no.

```javascript
// non-authenticated routes
router.post('/login', passport.authenticate('local-login', {
    successRedirect: '/student/courses',
    failureRedirect: '/login',
    failureFlash: true
}));

router.post('/uteach-login', passport.authenticate('auth0', {
    successRedirect: '/student/courses',
    failureRedirect: '/login',
    failureFlash: true
}), function(req,res) {
    res.redirect('/student/courses');
});

// check if user is authenticated
router.use((req, res, next) => {
    if (req.isAuthenticated())
        return next();
    res.redirect('/login');
});
```

The new design encapsulates all logic within their own classes, router only serves as a mounting point.

```javascript
const controllers = require('../Controllers/Student');

let router = require('express').Router();

const GetCourseByParameterMiddleware       = require('../Middlewares/ParameterMiddlewares/GetCourseByParameterMiddleware');
const GetQuestionByParameterMiddleware     = require('../Middlewares/ParameterMiddlewares/GetQuestionByParameterMiddleware');
const GetTutorialQuizByParameterMiddleware = require('../Middlewares/ParameterMiddlewares/GetTutorialQuizByParameterMiddleware');
const EnsureAuthenticatedMiddleware        = require('../Middlewares/EnsureAuthenticatedMiddleware');

// Mount all middlewares
GetCourseByParameterMiddleware.applyToRouter('course', router);
GetQuestionByParameterMiddleware.applyToRouter('question', router);
GetTutorialQuizByParameterMiddleware.applyToRouter('tutorialQuiz', router);
EnsureAuthenticatedMiddleware.applyToRouter(router);

const StudentController  = require('../Controllers/Student/StudentController');
const FileController     = require('../Controllers/Student/FileController');
const QuestionController = require('../Controllers/Student/QuestionController');

let studentController  = StudentController.getInstance();
let fileController     = FileController.getInstance();
let questionController = QuestionController.getInstance();

// authenticated routes
router.get('/courses', studentController.getCourses);
router.get('/courses/:course/quizzes', studentController.getQuizzes);
router.get('/courses/:course/quizzes/:tutorialQuiz/start', controllers.TutorialQuiz.startQuiz);
router.get('/courses/:course/quizzes/:tutorialQuiz/submit-question', questionController.getQuestionForm);
router.post('/courses/:course/quizzes/:tutorialQuiz/submit-question', questionController.addQuestion);
router.get('/file/:id', fileController.getFileLinkById);

module.exports = router;
```

## Inconsistant Naming Schemes

This is an obvious one, if you look into socket.io folder, you can find events that are called `REQUEST_QUIZ` and `quizData`, which just looks weird.

I decided to go with `REQUEST_QUIZ` style.

## Ancient Async Practice

This is not really a design flaw, but more of a technical restrictions.

For example the following code:

```javascript
req.course.update({ $addToSet: { instructors: { $each: users }}}, err => {
    if (err)
        return next(err);
    req.flash('success', 'The list of instructors has been updated for the course.');
    res.sendStatus(200);
});
```

It is more readable if written in the following way:

```javascript
try {
    await req.course.update({ $addToSet: { instructors: { $each: users }}});
    req.flash('success', 'The list of instructors has been updated for the course.');
    res.sendStatus(200);
} catch (err) {
    return next(err);
}       
```

## Lacking Newlines

It is not good to have excessive newlines, but also bad to not have them at all. In the old code, there is no blank line between methods.

```javascript
// Populate files
QuestionSchema.methods.withFiles = function () {
    return this.populate({ path: 'files', options: { sort: { name: 1 }}});
};
// Check if question is a multiple choice question
QuestionSchema.methods.isMultipleChoice = function () {
    return this.type === 'multiple choice';
};
// Check if question is a multiple select question
QuestionSchema.methods.isMultipleSelect = function () {
    return this.type === 'multiple select';
};
// Check if question is a short answer question
QuestionSchema.methods.isShortAnswer = function () {
    return this.type === 'short answer';
};
```

Much nicer this way:

```javascript
// Populate files
QuestionSchema.methods.withFiles = function () {
    return this.populate({ path: 'files', options: { sort: { name: 1 }}});
};

// Check if question is a multiple choice question
QuestionSchema.methods.isMultipleChoice = function () {
    return this.type === 'multiple choice';
};

// Check if question is a multiple select question
QuestionSchema.methods.isMultipleSelect = function () {
    return this.type === 'multiple select';
};

// Check if question is a short answer question
QuestionSchema.methods.isShortAnswer = function () {
    return this.type === 'short answer';
};
```

There are more design problems that I haven't noticed yet, I will update this post as I code.