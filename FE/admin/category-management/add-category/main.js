let categoriesArray = [];
const selectFatherCategory = document.querySelector('#father-name');
const getFatherCategory = async () => {
    try {
        let a = await axios({
            url: 'http://localhost/api/categories/get-all-categories.php',
            method: 'get',
            data: null,
        })
        categoriesArray = a.data.data.filter(item => {
            return item.fatherCateId === null;
        })
        let result = categoriesArray.map(item => {
            return `<option value="${item.name}">
                ${item.name}
            </option>`
        })
        selectFatherCategory.innerHTML = result.join('');
    } catch (error) {
        console.error(error.response)
    }
}
getFatherCategory();
const addCategory = async (objValue) => {
    try {
        let a = await axios({
            url: 'http://localhost/api/categories/create-category.php',
            method: 'post',
            data: objValue,
            headers: {

                'Authorization': `Bearer ${localStorage.getItem('token')}`
            }
        })
        console.log(a.data);
    }
    catch (error) {
        console.error(error.response)
    }
}

const form = document.querySelector('#Add-category');
form.onsubmit = async (e) => {
    try {
        e.preventDefault();
        const selectedNameCate = document.querySelector('input[name="name"]');
        const nameValue = selectedNameCate.value;

        const selectedFatherCate = form.querySelector('select[name="father-name"]');
        const selectedFatherCateValue = selectedFatherCate.options[selectedFatherCate.selectedIndex].value;
        let categoryId = 0;
        categoriesArray.forEach(item => {
            if (item.name === selectedFatherCateValue) {
                categoryId = item.id;
            }
        });
        await addCategory({
            name: nameValue,
            fatherCateId: categoryId,
        });
        window.location.href = '../index.html';
    } catch (error) {
        console.error(error.response)
    }
}