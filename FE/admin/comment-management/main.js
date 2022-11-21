const commentIfo = document.querySelector('.content-table');

const deleteComment = async (id) => {
    try {

        await axios({
            url: 'http://localhost/api/comments/delete-comment.php',
            method: 'delete',
            data: {
                id: id
            },
            headers: {
                'Authorization': `Bearer ${localStorage.getItem('token')}`
            }
        })

    } catch (error) {
        console.error(error.response)
    }
}

const main = async () => {
    // try {
    let a = await axios({
        url: 'http://localhost/api/comments/get-all-comments.php',
        method: 'get',
        data: null,
    })
    console.log(a.data.data);
    let result = a.data.data.map(item => {
        return `
            <td>${item.id}</td>
            <td>${item.content}</td>
            <td>${item.cmtDate}</td>
            <td>${item.updateAt}</td>
            <td>${item.displayName}</td>
            <td>${item.UserCreatedAt}</td>
            <td>${item.UserUpdateAt}</td>
            <td><button user-id=${item.user_Id} data-id=${item.id} class="delete-btn">Xóa</button></td>
        `
    });
    result.forEach(element => {
        let para = document.createElement("tr")
        para.innerHTML = element
        commentIfo.appendChild(para)

    });
    const deleteBtn = document.querySelectorAll('.delete-btn');
    console.log(deleteBtn)
    deleteBtn.forEach(element => {
        element.onclick = async function (e) {
            try {
                let isCheckDelete = window.confirm("Are you sure you want to delete ?")
                if (isCheckDelete) {
                    const id = e.target.getAttribute("data-id");
                    await deleteComment(id);
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

main();