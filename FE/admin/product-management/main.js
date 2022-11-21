
//query
const productInfo = document.querySelector('.content__table')
const productArr = [];


//delete product api
const deleteProduct = async (pro_id) => {
    try {
        await axios({
            url: 'http://localhost/api/products/delete-product.php',
            method: 'delete',
            data: {
                pro_Id: pro_id
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
    let ProductDetail = {};
    // try {
    let a = await axios({
        url: 'http://localhost/api/products/get-products.php',
        method: 'get',
        data: null,
    })
    let result = a.data.data.map(item => {
        return `
           
           <td>${item.id}</td>
           <td>${item.productName}</td>
           <td>${item.price}</td>
           <td>${item.promotion}</td>
           <td>${item.manufacturerName}</td>
           <td>${item.amount}</td>
           <td><button data-id=${item.id} class="delete-btn">Xóa</button><button class="edit-btn"><a data-id=${item.id} href="./edit-product/edit-product.html?id=${item.id}">Sửa</a></button></td>
            `
    })
    result.forEach(element => {
        let para = document.createElement("tr")
        para.innerHTML = element
        productInfo.appendChild(para)

    });

    //delete product
    const deleteBtn = document.querySelectorAll('.delete-btn');
    deleteBtn.forEach(element => {

        element.onclick = async function (e) {
            let isCheckDelete = window.confirm("Are you sure you want to delete ?");
            if (isCheckDelete) {
                const value = e.target.getAttribute("data-id");
                await deleteProduct(value)
                location.reload();
            }
            else {
                return
            }

        }
    });
    //edit product
    const editButton = document.querySelectorAll('.edit-btn');
    editButton.forEach(item => {
        // item.setAttribute("href", "./add_product/add_product.html");
        item.onclick = function (e) {
            let id_Pro = e.target.getAttribute('data-id');
            a.data.data.forEach((product) => {
                if (product.id === id_Pro) {
                    ProductDetail = product;
                }
            })
            // localStorage.setItem('productDetail', JSON.stringify(ProductDetail))
            console.log(ProductDetail);
        }
    })
    // } catch (error) {
    //     console.error(error.response)
    // }
}
//start
main()

