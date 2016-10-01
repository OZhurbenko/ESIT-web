//helper used by other functions below
function matchRegexp(value, regexp) {
  return regexp.test(value);
}

function isExisty(value) {
  return value !== null && value !== undefined;
}

function isEmpty(value) {
  return value === '';
}

function isEmptyString(value) {
  return value === '';
}

function isUrl(url) {
  if(matchRegexp(url, /^(https?|s?ftp):\/\/(((([a-z]|\d|-|\.|_|~|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])|(%[\da-f]{2})|[!\$&'\(\)\*\+,;=]|:)*@)?(((\d|[1-9]\d|1\d\d|2[0-4]\d|25[0-5])\.(\d|[1-9]\d|1\d\d|2[0-4]\d|25[0-5])\.(\d|[1-9]\d|1\d\d|2[0-4]\d|25[0-5])\.(\d|[1-9]\d|1\d\d|2[0-4]\d|25[0-5]))|((([a-z]|\d|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])|(([a-z]|\d|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])([a-z]|\d|-|\.|_|~|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])*([a-z]|\d|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])))\.)+(([a-z]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])|(([a-z]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])([a-z]|\d|-|\.|_|~|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])*([a-z]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])))\.?)(:\d*)?)(\/((([a-z]|\d|-|\.|_|~|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])|(%[\da-f]{2})|[!\$&'\(\)\*\+,;=]|:|@)+(\/(([a-z]|\d|-|\.|_|~|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])|(%[\da-f]{2})|[!\$&'\(\)\*\+,;=]|:|@)*)*)?)?(\?((([a-z]|\d|-|\.|_|~|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])|(%[\da-f]{2})|[!\$&'\(\)\*\+,;=]|:|@)|[\uE000-\uF8FF]|\/|\?)*)?(#((([a-z]|\d|-|\.|_|~|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])|(%[\da-f]{2})|[!\$&'\(\)\*\+,;=]|:|@)|\/|\?)*)?$/i)) {
    return true;
  } else {
    return false;
  }
}

function isNumeric(value) {
  if (typeof value === 'number') {
    return true;
  }
  return matchRegexp(value, /^[-+]?(?:\d*[.])?\d+$/);
}

function isAlpha(value) {
  return matchRegexp(value, /^[A-Z]+$/i);
}

function isAlphanumeric(value) {
  return matchRegexp(value, /^[0-9A-Z]+$/i);
}

function isInt(value) {
  return matchRegexp(value, /^(?:[-+]?(?:0|[1-9]\d*))$/);
}

function isFloat(value) {
  return matchRegexp(values, value, /^(?:[-+]?(?:\d+))?(?:\.\d*)?(?:[eE][\+\-]?(?:\d+))?$/);
}

function isWords(value) {
  return matchRegexp(value, /^[A-Z\s]+$/i);
}

function isSpecialWords(value) {
  return matchRegexp(values, value, /^[A-Z\s\u00C0-\u017F]+$/i);
}

function maxLength(value, length) {
  return !isExisty(value) || value.length <= length;
}

function minLength(value, length) {
  return !isExisty(value) || isEmpty(value) || value.length >= length;
}



//TODO REMOVE 3 following functions
function validateLogin(login) {
  if(login !== null && login !== undefined && login !== ''
                    && matchRegexp(login, /^[0-9A-Z]+$/i)
                    && login.length > 6) {
    console.log('Login passed the validation');
    return true;
  } else {
    console.log('Login failed the validation');
    return false;
  }
}

function validatePassword(password) {
  if(matchRegexp(password, /^(?=.*[0-9])(?=.*[!@#$%^&*])[a-zA-Z0-9\u00C0-\u017F!@#$%^&*]{8,16}$/)) {
    console.log('validated password!');
    return true;
  } else {
    return false;
  }
}

function validateEmail(email) {
  if(matchRegexp(email, /^((([a-z]|\d|[!#\$%&'\*\+\-\/=\?\^_`{\|}~]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])+(\.([a-z]|\d|[!#\$%&'\*\+\-\/=\?\^_`{\|}~]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])+)*)|((\x22)((((\x20|\x09)*(\x0d\x0a))?(\x20|\x09)+)?(([\x01-\x08\x0b\x0c\x0e-\x1f\x7f]|\x21|[\x23-\x5b]|[\x5d-\x7e]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])|(\\([\x01-\x09\x0b\x0c\x0d-\x7f]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF]))))*(((\x20|\x09)*(\x0d\x0a))?(\x20|\x09)+)?(\x22)))@((([a-z]|\d|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])|(([a-z]|\d|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])([a-z]|\d|-|\.|_|~|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])*([a-z]|\d|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])))\.)+(([a-z]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])|(([a-z]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])([a-z]|\d|-|\.|_|~|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])*([a-z]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])))$/i)) {
    return true;
  } else {
    return false;
  }
}


module.exports = {

  isExisty,
  isEmpty,
  isEmptyString,
  isUrl,
  isNumeric,
  isAlpha,
  isAlphanumeric,
  isInt,
  isFloat,
  isWords,
  isSpecialWords,
  maxLength,
  minLength,

  //TODO remove next 3 functions
  validateLogin,
  validatePassword,
  validateEmail
}
