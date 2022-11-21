const userInfo = document.querySelector(".content__table");

//delete user api
const deleteUser = async (user_id) => {
    try {

        await axios({
            url: 'http://localhost/api/auth/delete-user.php',
            method: 'delete',
            data: {
                user_Id: user_id
            },
            headers: {

                'Authorization': `Bearer ${localStorage.getItem('token')}`
            }
        })

    } catch (error) {
        console.error(error.response)
    }
}

//main function
const main = async () => {
    // try {
    let a = await axios({
        url: 'http://localhost/api/auth/get-all-users.php',
        method: 'get',
        data: null,
    })

    const arrayUser = a.data.filter(item => {
        return item.role === "user";
    })
    let result = arrayUser.map(item => {
        return `
           
           <td>${item.id}</td>
           <td>${item.userName}</td>
           <td>${item.displayName}</td>
           <td>${item.email}</td>
           <td>${item.sex}</td>
           <td>${item.phoneNumber}</td>
           <td>${item.address}</td>
           <td>${item.age}</td>
           <td><button data-id=${item.id} class="delete-btn">Xóa</button></td>
            `
    })
    result.forEach(element => {
        let para = document.createElement("tr")
        para.innerHTML = element
        userInfo.appendChild(para)

    });
    // delete user
    const deleteBtn = document.querySelectorAll('.delete-btn');
    deleteBtn.forEach(element => {
        element.onclick = async function (e) {
            try {
                let isCheckDelete = window.confirm("Are you sure you want to delete ?")
                if (isCheckDelete) {
                    const value = e.target.getAttribute("data-id");
                    const y = await deleteUser(value)
                    location.reload();
                }
                else {
                    return
                }
            } catch (error) {
                console.error(error.response);
            }

        }
    });
}

main()