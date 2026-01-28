<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Registration Form</title>
<style>
    body { font-family: "Times New Roman", serif; }
    h1 { margin: 10px 0 15px 10px; }
    .wrap { width: 460px; margin: 0 auto; }
    table { width: 100%; border-collapse: collapse; }
    td { padding: 6px 6px; vertical-align: middle; }
    td.label { width: 120px; text-align: right; padding-right: 10px; }
    input[type="text"], input[type="password"], select {
        width: 260px; padding: 3px; border: 1px solid #7aa6ff;
    }
    textarea {
        width: 260px; height: 140px; border: 1px solid #7aa6ff;
    }
    .msg { color: red; font-size: 14px; padding-left: 8px; white-space: nowrap; }
    .btnRow { text-align: center; padding-top: 10px; }
    button { padding: 3px 18px; font-size: 16px; }
</style>

<script>
function byId(id){ return document.getElementById(id); }

function setMsg(id, text) {
    byId(id).textContent = text || "";
}

function isAlphaSpace(s) {
    return /^[A-Za-z\s]+$/.test(s);
}
function isNumeric(s) {
    return /^\d+$/.test(s);
}
function isValidEmail(s) {
    return /^[^\s@]+@[^\s@]+\.[^\s@]+$/.test(s);
}

function clearAllMsgs() {
    const ids = ["useridMsg","passMsg","nameMsg","countryMsg","zipMsg","emailMsg","sexMsg","langMsg"];
    ids.forEach(i => setMsg(i,""));
}

function validateForm(e) {
    clearAllMsgs();

    const userid = byId("userid").value.trim();
    const passid = byId("passid").value;
    const username = byId("username").value.trim();
    const country = byId("country").value;
    const zip = byId("zip").value.trim();
    const email = byId("email").value.trim();

    const sexMale = byId("sex_m").checked;
    const sexFemale = byId("sex_f").checked;

    const langEnglish = byId("lang_en").checked;
    const langNonEnglish = byId("lang_non").checked;

    let ok = true;

    // User id: Required 5 to 12
    if (userid.length === 0 || userid.length < 5 || userid.length > 12) {
        setMsg("useridMsg", "Required and must be of length 5 to 12.");
        ok = false;
    }

    // Password: Required 7 to 12
    if (passid.length === 0 || passid.length < 7 || passid.length > 12) {
        setMsg("passMsg", "Required and must be of length 7 to 12.");
        ok = false;
    }

    // Name: Required and alphabets only
    if (username.length === 0 || !isAlphaSpace(username)) {
        setMsg("nameMsg", "Required and alphabates only.");
        ok = false;
    }

    // Country: Required select
    if (country === "" || country === "select") {
        setMsg("countryMsg", "Required.  Must select a country.");
        ok = false;
    }

    // ZIP: Required numeric only
    if (zip.length === 0 || !isNumeric(zip)) {
        setMsg("zipMsg", "Required. Must be numeric only.");
        ok = false;
    }

    // Email: Required valid email
    if (email.length === 0 || !isValidEmail(email)) {
        setMsg("emailMsg", "Required. Must be a valid email.");
        ok = false;
    }

    // Sex: Required
    if (!sexMale && !sexFemale) {
        setMsg("sexMsg", "Required.");
        ok = false;
    }

    // Language: Required (at least one checked)
    if (!langEnglish && !langNonEnglish) {
        setMsg("langMsg", "Required.");
        ok = false;
    }

    if (!ok) {
        e.preventDefault();
        return false;
    }
    return true;
}

window.addEventListener("DOMContentLoaded", () => {
    byId("regForm").addEventListener("submit", validateForm);
});
</script>
</head>

<body>
<div class="wrap">
    <h1>Registration Form</h1>

    <%
        String dbUserError = (String) request.getAttribute("useridError");
        String dbEmailError = (String) request.getAttribute("emailError");
        String dbGeneralError = (String) request.getAttribute("generalError");
    %>

    <% if (dbGeneralError != null) { %>
        <p class="msg"><%= dbGeneralError %></p>
    <% } %>

    <form id="regForm" action="register" method="post">
        <table>
            <tr>
                <td class="label">User id:</td>
                <td>
                    <input type="text" id="userid" name="userid">
                    <span class="msg" id="useridMsg"><%= (dbUserError != null) ? dbUserError : "" %></span>
                </td>
            </tr>
            <tr>
                <td class="label">Password:</td>
                <td>
                    <input type="password" id="passid" name="passid">
                    <span class="msg" id="passMsg"></span>
                </td>
            </tr>
            <tr>
                <td class="label">Name:</td>
                <td>
                    <input type="text" id="username" name="username">
                    <span class="msg" id="nameMsg"></span>
                </td>
            </tr>
            <tr>
                <td class="label">Address:</td>
                <td>
                    <input type="text" id="address" name="address">
                    <span class="msg" style="color:red;">Optional.</span>
                </td>
            </tr>
            <tr>
                <td class="label">Country:</td>
                <td>
                    <select id="country" name="country">
                        <option value="select">(Please select a country)</option>
                        <option value="Canada">Canada</option>
                        <option value="India">India</option>
                        <option value="USA">USA</option>
                        <option value="UK">UK</option>
                    </select>
                    <span class="msg" id="countryMsg"></span>
                </td>
            </tr>
            <tr>
                <td class="label">ZIP Code:</td>
                <td>
                    <input type="text" id="zip" name="zip">
                    <span class="msg" id="zipMsg"></span>
                </td>
            </tr>
            <tr>
                <td class="label">Email:</td>
                <td>
                    <input type="text" id="email" name="email">
                    <span class="msg" id="emailMsg"><%= (dbEmailError != null) ? dbEmailError : "" %></span>
                </td>
            </tr>
            <tr>
                <td class="label">Sex:</td>
                <td>
                    <label><input type="radio" id="sex_m" name="sex" value="Male">Male</label>
                    <label><input type="radio" id="sex_f" name="sex" value="Female">Female</label>
                    <span class="msg" id="sexMsg"></span>
                </td>
            </tr>
            <tr>
                <td class="label">Language:</td>
                <td>
                    <label><input type="checkbox" id="lang_en" name="language" value="English">English</label>
                    <label><input type="checkbox" id="lang_non" name="language" value="Non English">Non English</label>
                    <span class="msg" id="langMsg"></span>
                </td>
            </tr>
            <tr>
                <td class="label" style="vertical-align: top;">About:</td>
                <td>
                    <textarea id="about" name="about"></textarea>
                    <div class="msg" style="text-align:center; margin-top:-120px;">Optional.</div>
                </td>
            </tr>
            <tr>
                <td colspan="2" class="btnRow">
                    <button type="submit">Submit</button>
                </td>
            </tr>
        </table>
    </form>
</div>
</body>
</html>
