//declare global methods here
var currentIndex = 0;
var lastIndex = 0;
var rightQs = [];
var wrongQs = [];
var totalQuizScore = 0;
var perQuesWeight = 1;
var quizSummaryGenerated = false;
var isQuizComplete = false;
var interval = 0;
// this will called when document is ready



$(document).ready(function () {
    setActiveNav();
    initializeIndex();
    bindEvents();
    if (getPageName() == 'quiz') {
        $(window).bind("beforeunload", function (event) {
            if (!isQuizComplete) return "You have unsaved changes";
        });
    }
    if (getPageName().indexOf("questions") > -1) {
        $("#students").dataTable({
            "pageLength": 100
        });
    }
    if (getPageName() == "new" || getPageName() == "edit") {
        initializeCloudinary();
        bindCloudinaryEvents();
        bindFormEvents();
    }
});

function createImage(elem, data, type) {
    elem.html(
        $.cloudinary.image(data.result.public_id,
            {
                format: data.result.format, version: data.result.version,
                class: 'img-thumbnail img-fluid'
            }));
}

function bindCloudinaryEvents() {
    $('.fu1').bind('cloudinarydone', function (e, data) {
        $(".update1").text("Image Uploaded!");
        $(".update1").addClass("success");
        $("#question_option1").val(data.result.secure_url);
        $("#question_option1").attr("disabled", "disabled");
        $("#question_option1").trigger("focusout");
        if ($(".preview1").length > 0) {
            createImage($(".preview1"), data);
        }
    });
    $('.fu2').bind('cloudinarydone', function (e, data) {
        $(".update2").text("Image Uploaded!");
        $(".update2").addClass("success");
        $("#question_option2").val(data.result.secure_url);
        $("#question_option2").attr("disabled", "disabled");
        $("#question_option2").trigger("focusout");
        if ($(".preview2").length > 0) {
            createImage($(".preview2"), data);
        }
    });
    $('.fu3').bind('cloudinarydone', function (e, data) {
        $(".update3").text("Image Uploaded!");
        $(".update3").addClass("success");
        $("#question_option3").val(data.result.secure_url);
        $("#question_option3").attr("disabled", "disabled");
        $("#question_option3").trigger("focusout");
        if ($(".preview3").length > 0) {
            createImage($(".preview3"), data);
        }
    });
    $('.fu4').bind('cloudinarydone', function (e, data) {
        $(".update4").text("Image Uploaded!");
        $(".update4").addClass("success");
        $("#question_option4").val(data.result.secure_url);
        $("#question_option4").attr("disabled", "disabled");
        $("#question_option4").trigger("focusout");
        if ($(".preview4").length > 0) {
            createImage($(".preview4"), data);
        }
    });
    $('.fu5').bind('cloudinarydone', function (e, data) {
        $(".update5").text("Image Uploaded!");
        $(".update5").addClass("success");
        $("#question_option5").val(data.result.secure_url);
        $("#question_option5").attr("disabled", "disabled");
        $("#question_option5").trigger("focusout");
        if ($(".preview5").length > 0) {
            createImage($(".preview5"), data);
        }
    });
    $('.fuquestion').bind('cloudinarydone', function (e, data) {
        $(".updatequestion").text("Image Uploaded!");
        $(".updatequestion").addClass("success");
        $("#question_question").val(data.result.secure_url);
        $("#question_question").attr("disabled", "disabled");
        $("#question_question").trigger("focusout");
        if ($(".previewquestion").length > 0) {
            createImage($(".previewquestion"), data);
        }
    });
}
function bindFormEvents() {
    $("#createQuestionForm").validate({
        rules: {
            "question[question]": "required",
            "question[option1]": "required",
            "question[option2]": "required",
            "question[option3]": "required",
            "question[option4]": "required",
            "question[option5]": "required",
            "question[answer]": "required"
        },
        submitHandler: function (form) {
            form.submit();
        }
    });
}

function endQuiz(){
  //disable all radio buttons
  $("input[type='radio']").prop("disabled", true);
  //create right question array
  //create wrong response array
  //update last question or first question
  checkForCorrectAnswer($(".questionItem").eq(currentIndex));
  findRightWrongQs();
  //calculcate score
  totalQuizScore = perQuesWeight * rightQs.length;
  generateSumamryView();
  isQuizComplete = true;

}

function bindEvents() {
    $("#submitQuiz").on("click", function () {
        if (confirm("This will submit the quiz. You won't be able to modify your answer choice. Click Ok to continue.")) {
	  clearInterval(interval);
          endQuiz();
        }
    });
}
function generateSumamryView() {
    var quizContainer = $(".container #quizContainer");
    var correctResponse = "";
    var incorrectResponse = "";
    if (rightQs.length > 0) {
        correctResponse += "<ul class='list-inline'>";
        for (var i = 0; i < rightQs.length; i++) {
            correctResponse += "<li class='list-inline-item'><a href='#' onclick='showQuestion(" + rightQs[i] + ")'>Q" + ++rightQs[i] + "</a></li>";
        }
        correctResponse += "</ul>";
    }
    else
        correctResponse = "None";
    if (wrongQs.length > 0) {
        incorrectResponse += "<ul class='list-inline'>";
        for (var i = 0; i < wrongQs.length; i++) {
            incorrectResponse += "<li class='list-inline-item'><a href='#' onclick='showQuestion(" + wrongQs[i] + ")'>Q" + ++wrongQs[i] + "</a></li>";
        }
        incorrectResponse += "</ul>";
    }
    else { incorrectResponse = "None"; }
    var html = "<div class='col-md-4'><div id='summary' class='jumbotron'><h3 class='totalscore text-center'>Total Score: " + totalQuizScore +
        "</h3><div id='questionresult' class='--margintop16'><fieldset id='correctresponse' class='form-group --marginbottom8'><legend>Correct responses</legend>" + correctResponse +
        "</fieldset><fieldset id='incorrectresponse' class='form-group'><h4>Incorrect responses</h4>" + incorrectResponse + "</fieldset></div></div></div >";
    quizContainer.removeClass("col-md-12");
    quizContainer.addClass("col-md-8");
    quizContainer.parent().append(html);
    $("#showAnswerBtn").removeClass("hide");
    $("#submitQuiz").addClass("hide");
    quizSummaryGenerated = true;
}
function findRightWrongQs() {
    $(".questionItem").each(function (index) {
        var question = $(this);
        var index = parseInt(question.attr("data-index"));
        //for matching the index of answer choices
        if (question.hasClass("correctResponse"))
            rightQs.push(index);
        else
            wrongQs.push(index);

    });
}

function showQuestion(index) {
    var questions = $(".questionItem");
    questions.removeClass("show");
    questions.addClass("hide");
    questions.eq(index).removeClass("hide");
    showAnswer();
    initializeIndex();
}
function checkForCorrectAnswer(elem) {
    var correctAnswer = parseInt(elem.attr("data-answer")) - 1;
    var selectResponse = parseInt(elem.find(".option:checked").attr("data-index"));
    if (isNaN(selectResponse)) {
        elem.addClass("wrongResponse");
        elem.removeClass("correctResponse");
    }
    else {
        if (selectResponse == correctAnswer) {
            elem.removeClass("wrongResponse");
            elem.addClass("correctResponse")
        }
        else {
            elem.removeClass("correctResponse");
            elem.addClass("wrongResponse")
        }
    }

}
function getPageName() {
    return location.pathname.split('/').slice(-1)[0].toLowerCase();
}

function initializeCloudinary() {
    if ($.fn.cloudinary_fileupload !== undefined) {
        $("input.cloudinary-fileupload[type=file]").cloudinary_fileupload();
    }
}
function initializeIndex() {
    currentIndex = $(".questionItem:not(.hide)").index();
    lastIndex = $(".questionItem").length - 1;
    if (currentIndex == lastIndex) {
        //disable next
        $(".next").prop("disabled", true);
        $("#submitQuiz").prop("disabled", false);
    }
    else {
        $(".next").prop("disabled", false);
        $("#submitQuiz").prop("disabled", true);
    }
    if (currentIndex == 0)
        $(".previous").prop("disabled", true);
    else
        $(".previous").prop("disabled", false);
}

function showAnswer() {
    var elem = $(".questionItem:not(.hide)");
    var correctAnswer = elem.attr("data-answer");
    //highlight right answer
    elem.find(".choices").children().eq(correctAnswer - 1).addClass("correct");
}

function getNext() {
    //clear correct or wrong classes
    $(".correct").removeClass("correct");
    if (currentIndex < lastIndex) {
        //hide the current element
        $(".questionItem").eq(currentIndex).removeClass("show");
        $(".questionItem").eq(currentIndex).addClass("hide");
        if (!quizSummaryGenerated)
            checkForCorrectAnswer($(".questionItem").eq(currentIndex));
        //increament current index
        currentIndex++;
        //show the next element with new current index
        $(".questionItem").eq(currentIndex).addClass("show");
        $(".questionItem").eq(currentIndex).removeClass("hide");

        initializeIndex();
    }
}
function toQuestion(idx) {
    //clear correct or wrong classes
    $(".correct").removeClass("correct");
    //hide the current element
    $(".questionItem").eq(currentIndex).removeClass("show");
    $(".questionItem").eq(currentIndex).addClass("hide");
    if (!quizSummaryGenerated)
        checkForCorrectAnswer($(".questionItem").eq(currentIndex));
    //update current index
    currentIndex = idx;
    //show the target element with new current index
    $(".questionItem").eq(currentIndex).addClass("show");
    $(".questionItem").eq(currentIndex).removeClass("hide");

    initializeIndex();
}
function setBookmark() {
    if( $(".bookMarkItem").eq(currentIndex).hasClass("show") ){
        //hide the  element if unchecked
        $(".bookMarkItem").eq(currentIndex).addClass("hide");
        $(".bookMarkItem").eq(currentIndex).removeClass("show");
    }
    else{
        //show the element if checked
        $(".bookMarkItem").eq(currentIndex).addClass("show");
        $(".bookMarkItem").eq(currentIndex).removeClass("hide");
    }
}

function setActiveNav() {
    var pageName = getPageName().toLocaleLowerCase();
    //reset
    var navs = $(".navbar-nav li");
    navs.removeClass("active");
    if (pageName == 'selquiz' || pageName == 'quiz') {
        navs.eq(2).addClass("active");
    }
    if (pageName == 'selcat' || pageName == 'practice') {
        navs.eq(1).addClass("active");
    }
    if (pageName == 'home') {
        navs.eq(0).addClass("active");
    }

    if (pageName == 'login') {
        $('.order-3 .navbar-nav li').addClass("active");
    }
}

function quitQuiz(){
    window.location.href = "/selquiz";
}

function positionFooter() {
    var footerHeight = 0,
        footerTop = 0,
        $footer = $(".footer");
    footerHeight = $footer.height();
    footerTop = ($(window).scrollTop() + $(window).height() - footerHeight) + "px";

    if (($(document.body).height() + footerHeight) < $(window).height()) {
        $footer.css({
            position: "absolute",
            top: footerTop
        });
    } else {
        $footer.css({
            position: "static"
        })
    }
    $footer.removeClass("hide");
    $(window)
        .scroll(this.positionFooter)
        .resize(this.positionFooter)
}

function getPrevious() {
    //clear correct or wrong classes
    $(".correct").removeClass("correct");
    if (currentIndex > 0) {
        //hide the current element
        $(".questionItem").eq(currentIndex).removeClass("show");
        $(".questionItem").eq(currentIndex).addClass("hide");
        //increament current index
        currentIndex--;
        //show the next element with new current index
        $(".questionItem").eq(currentIndex).addClass("show");
        $(".questionItem").eq(currentIndex).removeClass("hide");
        initializeIndex();
    }
}

// duration: in seconds
function startTimer(duration, display) {
    var timer = duration, hours, minutes, seconds;
    interval = setInterval(function () {
        hours = parseInt(timer/3600,10)
        minutes = parseInt((timer%3600)/60,10)
        seconds = parseInt(timer % 60, 10)

        hours = hours < 10 ? "0" + hours : hours;
        minutes = minutes < 10 ? "0" + minutes : minutes;
        seconds = seconds < 10 ? "0" + seconds : seconds;

        display.textContent = hours + ":" + minutes + ":" + seconds;

        if (--timer < 0) {
            alert('Time is up');
            clearInterval(interval);
            endQuiz();
        }
    }, 1000);
}