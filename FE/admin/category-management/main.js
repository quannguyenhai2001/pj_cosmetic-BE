
//query
const categoriInfo = document.querySelector('.content-table')

const deleteCate = async (id) => {
    try {

        await axios({
            url: 'http://localhost/api/categories/delete-category.php',
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


//main function
const main = async () => {
    // try {
    let a = await axios({
        url: 'http://localhost/api/categories/get-all-categories.php',
        method: 'get',
        data: null,
    })
    let ArrayFatherCate = a.data.data.filter(item => {
        return item.fatherCateId === null;
    })

    let arrayChildCate = a.data.data.filter(item => {
        return item.fatherCateId !== null;
    });
    let newArray = arrayChildCate.map(item => {
        let valueName = '';
        ArrayFatherCate.forEach(element => {
            if (item.fatherCateId === element.id) {
                valueName = element.name;
            }
        });
        return { ...item, fatherName: valueName };
    })
    let result = newArray.map(item => {
        return `
           
           <td>${item.id}</td>
           <td>${item.name}</td>
           <td>${item.fatherName}</td>
           <td><button class="delete-btn" data-id = ${item.id}>Xóa</button></td>
            `
    })
    result.forEach(element => {
        let para = document.createElement("tr")
        para.innerHTML = element
        categoriInfo.appendChild(para)

    });
    const deleteBtn = document.querySelectorAll('.delete-btn');

    deleteBtn.forEach(element => {
        element.onclick = async function (e) {
            try {
                let isCheckDelete = window.confirm("Are you sure you want to delete ?")
                if (isCheckDelete) {
                    const value = e.target.getAttribute("data-id");
                    await deleteCate(value)
                    location.reload();
                }
                else {
                    return
                }
            } catch (error) {
                console.error(error.response);
            }

        }
    })

}



//start
main()
