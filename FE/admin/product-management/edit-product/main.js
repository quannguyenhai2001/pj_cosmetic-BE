import CallApiByBody from "../../config.js";

const editForm = document.querySelector('#edit-product');
const selectName = editForm.querySelector('#name');
const selectPrice = editForm.querySelector('#price');
const selectPromotion = editForm.querySelector('#promotion');
const selectDescription = editForm.querySelector('#description');
const selectSize = editForm.querySelector('#size');
let idValue = 0;
let params = (new URL(document.location)).searchParams;
let id = params.get("id");

async function getDetail() {
    try {
        let a = await CallApiByBody(`products/get-detail-product.php?id=${id}`, 'GET', null);
        selectName.value = a.data.data.productName;
        selectPrice.value = a.data.data.price;
        selectPromotion.value = a.data.data.promotion;
        selectDescription.value = a.data.data.description;
        idValue = a.data.data.id;
        console.log(a.data.data);
        for(let j = 0; j<2 ; j++) {
            if(selectSize.options[j].value === a.data.data.size) {
                selectSize.selectedIndex = j;
                break;
            }
        }

    } catch (error) {
        console.log(error);
    }
}
getDetail();
const editProduct = async (objValue) => {
    try {
        let a = await axios({
            url: 'http://localhost/api/products/update-product.php',
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
const form = document.querySelector('#edit-product');
form.onsubmit = async function (e) {
    try {
        e.preventDefault();
        const nameValue = selectName.value;
        const priceValue = selectPrice.value;
        const promotionValue = selectPromotion.value;
        const descriptionValue = selectDescription.value;   
        const sizeValue = selectSize.value;
        const selectedImage = form.querySelector('#image');
        const imageValue = selectedImage.files;

        let data = new FormData();
        data.append("id", idValue);
        data.append("name", nameValue);
        data.append("price", priceValue);
        data.append("promotion", promotionValue);
        data.append('description', descriptionValue);
        data.append('size', sizeValue);
        for (var i = 0; i < imageValue.length; i++) {
            data.append("image[]", imageValue[i]);
        }
        await editProduct(data);
        window.location.href = '../index.html';
    } catch (error) {
        console.log(error.response)
    }
}



