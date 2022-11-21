//variables
let manuArray = [];
let categoriesArray = [];

//
let name = '';
let price = 0;
let promotion = 0;
let description = '';
let amount = 0;


const selectManu = document.querySelector('#manufacturers');

const getManu = async () => {
    try {
        let a = await axios({
            url: 'http://localhost/api/manufacturers/get-all-manufacturers.php',
            method: 'get',
            data: null,
        })
        manuArray = a.data;
        let result = a.data.map(item => {
            return `<option value="${item.name}">
                ${item.name}
            </option>`
        })
        selectManu.innerHTML = result.join('');
    } catch (error) {
        console.error(error.response)
    }
}
getManu()

const selectCategory = document.querySelector('#category');
// var row = productInfo.insertRow(0);
// var cell1 = row.insertRow(0);
// cell1.innerHTML = "hello";
const getcategory = async () => {
    try {
        let a = await axios({
            url: 'http://localhost/api/categories/get-all-categories.php',
            method: 'get',
            data: null,
        })
        categoriesArray = a.data.data;
        let result = a.data.data.map(item => {
            return `<option value="${item.name}">
                ${item.name}
            </option>`
        })
        selectCategory.innerHTML = result.join('');
    } catch (error) {
        console.error(error.response)
    }
}
getcategory()

//add product
const addProduct = async (objValue) => {
    try {
        let a = await axios({
            url: 'http://localhost/api/products/create-product.php',
            method: 'post',
            data: objValue,
            headers: {

                'Authorization': `Bearer ${localStorage.getItem('token')}`
            }
        })
    } catch (error) {
        console.error(error.response.data)
    }
}

//submit form
const form = document.querySelector('#Add-product');
form.onsubmit = async function (e) {
    try {
        e.preventDefault();
        const selectedName = form.querySelector('input[name="name"]');
        const nameValue = selectedName.value;
        const selectedPrice = form.querySelector('input[name="price"]');
        const priceValue = selectedPrice.value;
        const selectedPromotion = form.querySelector('input[name="promotion"]');
        const promotionValue = selectedPromotion.value;
        const selectedDescription = form.querySelector('textarea[name="description"]');
        const descriptionValue = selectedDescription.value;
        const selectedSize = form.querySelector('select[name="size"]');
        const sizeValue = selectedSize.value;
        const selectedAmount = form.querySelector('input[name="amount"]');
        const amountValue = selectedAmount.value;
        const selectedImage = form.querySelector('input[name="image[]"]');
        const imageValue = selectedImage.files;
        console.log(imageValue);
        const selectManu = form.querySelector('select[name="manufacturers"]');
        const selectManuValue = selectManu.options[selectManu.selectedIndex].value;
        let manuId = 0;
        manuArray.forEach(element => {
            if (element.name === selectManuValue) {
                manuId = element.id;
            }
        });

        const selectCategory = form.querySelector('select[name="category"]');
        const selectCategoryValue = selectCategory.options[selectCategory.selectedIndex].value;
        let categoryId = 0;
        categoriesArray.forEach(element => {
            if (element.name === selectCategoryValue) {
                categoryId = element.id;
            }
        });

        let data = new FormData();
        data.append("name", nameValue);
        data.append("price", priceValue);
        data.append("promotion", promotionValue);
        data.append('description', descriptionValue);
        data.append('size', sizeValue);
        data.append("amount", amountValue);
        data.append("manu_Id", manuId);
        data.append("cate_Id", categoryId);
        for (var i = 0; i < imageValue.length; i++) {
            data.append("image[]", imageValue[i]);
        }
        await addProduct(data);
        window.location.href = '../index.html';
    } catch (error) {
        console.error(error.response.data)
    }
}

