import CallApiByBody from "../config.js";


const emailValue = document.getElementById('email');
const passwordValue = document.getElementById('password');
const signInBtn = document.getElementById('sign-in-btn');
let data = {};
signInBtn.onclick = async function (e) {
    e.preventDefault();
    try {
        let a = await CallApiByBody('/auth/sign-in.php','post',
            {
                email: emailValue.value,
                password: passwordValue.value
            }
        )
        console.log(a.data)
        data = a.data;
        if (data.user.role != 'admin') {
            try {
                let aa = await axios({
                    url: 'http://localhost/api/auth/sign-in.php',
                    method: 'post',
                    data: {
                        email: emailValue.value,
                        password: passwordValue.value
                    },
                })
            }
            catch (error) {
                console.error(error.response.data)
            }
        }
        else {
            localStorage.setItem('token', a.data.token);
            window.location.href = "../product-management/index.html";
        }
    } catch (error) {
        console.error(error.response)
    }
}
