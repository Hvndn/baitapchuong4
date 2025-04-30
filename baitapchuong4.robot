*** Settings ***
Library    SeleniumLibrary

*** Variables ***
${URL}              https://opensource-demo.orangehrmlive.com/web/index.php/auth/login
${VALID_USER}       Admin
${VALID_PASS}       admin123
${INVALID_USER}     wronguser
${INVALID_PASS}     wrongpass

*** Test Cases ***
Valid Login
    [Documentation]  Test login thành công 
    # 1 Mở trình duyệt chrome
    Open Browser    ${URL}    chrome
    # 2 ĐI đén trang web
    Go To    ${URL}
    Wait Until Element Is Visible    xpath=//input[@name="username"]    timeout=10
    # 3 Nhập username
    Input Text    xpath=//input[@name="username"]    ${VALID_USER}
    # 4 Nhập password
    Input Text    xpath=//input[@name="password"]    ${VALID_PASS}
    Wait Until Element Is Visible    xpath=//button[@type="submit"]    timeout=10
    # 5 Click vào button login
        TRY
        Click Element    xpath=//button[@type="submit"]
        Log To Console    click btn-login
    EXCEPT    
        Log To Console    Không tìm thấy btn subbmit
    END
    # 6 Kiểm tra đăng nhập thành công
        Wait Until Page Contains Element    xpath=//h6[text()="Dashboard"]    timeout=10
Page Should Contain Element         xpath=//h6[text()="Dashboard"]
        Log To Console  Đăng nhập thành công
Invalid Login
    [Documentation]  Test login thất bại với tài khoản không hợp lệ
     # 1 Mở trình duyệt chrome
    Open Browser    ${URL}    chrome
    # 2 ĐI đén trang web
    Go To    ${URL}
    Wait Until Element Is Visible    xpath=//input[@name="username"]    timeout=10
    # 3 Nhập username
    Input Text    xpath=//input[@name="username"]    ${INVALID_USER}
    # 4 Nhập password
    Input Text    xpath=//input[@name="password"]    ${INVALID_PASS}
    Wait Until Element Is Visible    xpath=//button[@type="submit"]    timeout=10
    # 5 Click vào button login
        TRY
        Click Element    xpath=//button[@type="submit"]
        Log To Console    click btn-login
    EXCEPT    
        Log To Console    Không tìm thấy btn subbmit
    END
    # 6 Kiểm tra đăng nhập 
        Wait Until Element Is Visible    xpath=//p[contains(text(), "Invalid credentials")]    timeout=10
Element Text Should Be           xpath=//p[contains(text(), "Invalid credentials")]    Invalid credentials
        Log To Console  Đăng nhập thất bại