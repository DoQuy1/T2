
<!-- #include file="./layout/header.asp" -->

<div class="mt-4">
    <section class="content-header">
            <div class="container-fluid">
                <div class="row mb-2">
                    <div class="col-sm-6">
                        <h1>User Management</h1>
                    </div>
                    <div class="col-sm-6">
                        <ol class="breadcrumb float-sm-right">
                            <li class="breadcrumb-item"><a href="index.asp">Home</a></li>
                            <li class="breadcrumb-item active">User Management</li>
                        </ol>
                    </div>
                </div>
            </div>
        </section>
</div>

<div class="row">
    <div class="col-12">
        <div class="card">
            <div class="card-body">
                <div class="row">
                    <div class="col-sm-5 pb-2">
                        <a href="" class="btn btn-danger mb-2"><i class="mdi mdi-plus-circle me-2"></i> Add User</a>
                    </div>
                </div>
                <div class="row">
                    <div class="col-sm-6">
                            <label for="" class="form-label">
                                Display
                                <select name="" id="" class="custom-select" style="width:auto">
                                    <option value="5">5</option>
                                    <option value="10">10</option>
                                    <option value="15">15</option>
                                    <option value="20">20</option>
                                    <option value="-1">All</option>
                                </select>
                                Users
                            </label>
                    </div>
                    <div class="col-sm-6">
                            <form class="form-inline">
                              <input class="form-control mr-sm-2" type="search" placeholder="Search" aria-label="Search">
                              <button class="btn btn-outline-success my-2 my-sm-0" type="submit">Search</button>
                            </form>
                    </div>
                </div>

                <div class="table-responsive">
                    <table class="table table-centered w-100 dt-responsive nowrap" id="products-datatable">
                        <thead class="table-light">
                            <tr>
                                <th class="all" style="width: 20px;">
                                    <div class="form-check">
                                        <input type="checkbox" class="form-check-input" id="customCheck1">
                                        <label class="form-check-label" for="customCheck1">&nbsp;</label>
                                    </div>
                                </th>
                                <th class="all">User</th>
                                <th>Name</th>
                                <th>Phone</th>
                                <th>Email</th>
                                <th>Pasword</th>
                                <th style="width: 85px;">Action</th>
                            </tr>
                        </thead>
                        <tbody>
                            <tr>
                                <td class="align-middle">
                                    <div class="form-check">
                                        <input type="checkbox" class="form-check-input" id="customCheck2">
                                        <label class="form-check-label" for="customCheck2">&nbsp;</label>
                                    </div>
                                </td>
                                <td class="align-middle">
                                    <img style="" src="./images/laptop-img.png" alt="contact-img" title="contact-img" class="rounded me-3" height="48" />
                                    <p class="m-0 d-inline-block align-middle font-16">
                                        <a href="" class="text-body">Amazing Modern Chair</a>
                                        <br/>
                                        <span class="text-warning mdi mdi-star"></span>
                                        <span class="text-warning mdi mdi-star"></span>
                                        <span class="text-warning mdi mdi-star"></span>
                                        <span class="text-warning mdi mdi-star"></span>
                                        <span class="text-warning mdi mdi-star"></span>
                                    </p>
                                </td>
                                <td class="align-middle">
                                    Nguyen Anh Tuan
                                </td>
                                <td class="align-middle">
                                    0000000000000
                                </td>
                                <td class="align-middle">
                                    1@gmail.com
                                </td>

                                <td class="align-middle">
                                    254
                                </td>

                                <td class="align-middle" >
                                    <a href=""><i class="fa-regular fa-eye"></i></a>
                                    <a href=""><i class="fa-regular fa-eye-slash"></i></a>
                                    <a href="editUser.asp?id="><i class="fa-regular fa-pen-to-square"></i></a>
                                    <a href=""><i class="fa-regular fa-trash-can"></i></a>
                                </td>
                            </tr>
                            
                            <tr>
                                <td>
                                    <div class="form-check">
                                        <input type="checkbox" class="form-check-input" id="customCheck3">
                                        <label class="form-check-label" for="customCheck3">&nbsp;</label>
                                    </div>
                                </td>
                                <td>
                                    <img src="assets/images/products/product-4.jpg" alt="contact-img" title="contact-img" class="rounded me-3" height="48" />
                                    <p class="m-0 d-inline-block align-middle font-16">
                                        <a href="" class="text-body">Biblio Plastic Armchair</a>
                                        <br/>
                                        <span class="text-warning mdi mdi-star"></span>
                                        <span class="text-warning mdi mdi-star"></span>
                                        <span class="text-warning mdi mdi-star"></span>
                                        <span class="text-warning mdi mdi-star"></span>
                                        <span class="text-warning mdi mdi-star-half"></span>
                                    </p>
                                </td>
                                <td>
                                    Wooden Chairs
                                </td>
                                <td>
                                    09/08/2018
                                </td>
                                <td>
                                    $8.99
                                </td>

                                <td>
                                    1,874
                                </td>
                                <td>
                                    <span class="badge bg-success">Active</span>
                                </td>
                                <td class="table-action">
                                    <a href="" class="action-icon"> <i class="mdi mdi-eye"></i></a>
                                    <a href="" class="action-icon"> <i class="mdi mdi-square-edit-outline"></i></a>
                                    <a href="" class="action-icon"> <i class="mdi mdi-delete"></i></a>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <div class="form-check">
                                        <input type="checkbox" class="form-check-input" id="customCheck4">
                                        <label class="form-check-label" for="customCheck4">&nbsp;</label>
                                    </div>
                                </td>
                                <td>
                                    <img src="assets/images/products/product-3.jpg" alt="contact-img" title="contact-img" class="rounded me-3" height="48" />
                                    <p class="m-0 d-inline-block align-middle font-16">
                                        <a href="" class="text-body">Branded Wooden Chair</a>
                                        <br/>
                                        <span class="text-warning mdi mdi-star"></span>
                                        <span class="text-warning mdi mdi-star"></span>
                                        <span class="text-warning mdi mdi-star"></span>
                                        <span class="text-warning mdi mdi-star"></span>
                                        <span class="text-warning mdi mdi-star-outline"></span>
                                    </p>
                                </td>
                                <td>
                                    Dining Chairs
                                </td>
                                <td>
                                    09/05/2018
                                </td>
                                <td>
                                    $68.32
                                </td>

                                <td>
                                    2,541
                                </td>
                                <td>
                                    <span class="badge bg-success">Active</span>
                                </td>

                                <td class="table-action">
                                    <a href="" class="action-icon"> <ion-icon name="create-outline"></ion-icon></a>
                                    <a href="" class="action-icon"> <i class="mdi mdi-square-edit-outline"></i></a>
                                    <a href="" class="action-icon"> <i class="mdi mdi-delete"></i></a>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <div class="form-check">
                                        <input type="checkbox" class="form-check-input" id="customCheck5">
                                        <label class="form-check-label" for="customCheck5">&nbsp;</label>
                                    </div>
                                </td>
                                <td>
                                    <img src="assets/images/products/product-4.jpg" alt="contact-img" title="contact-img" class="rounded me-3" height="48" />
                                    <p class="m-0 d-inline-block align-middle font-16">
                                        <a href="" class="text-body">Designer Awesome Chair</a>
                                        <br/>
                                        <span class="text-warning mdi mdi-star"></span>
                                        <span class="text-warning mdi mdi-star"></span>
                                        <span class="text-warning mdi mdi-star"></span>
                                        <span class="text-warning mdi mdi-star-half"></span>
                                        <span class="text-warning mdi mdi-star-outline"></span>
                                    </p>
                                </td>
                                <td>
                                    Baby Chairs
                                </td>
                                <td>
                                    08/23/2018
                                </td>
                                <td>
                                    $112.00
                                </td>

                                <td>
                                    3,540
                                </td>
                                <td>
                                    <span class="badge bg-success">Active</span>
                                </td>

                                <td class="table-action">
                                    <a href="" class="action-icon"> <i class="mdi mdi-eye"></i></a>
                                    <a href="" class="action-icon"> <i class="mdi mdi-square-edit-outline"></i></a>
                                    <a href="" class="action-icon"> <i class="mdi mdi-delete"></i></a>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <div class="form-check">
                                        <input type="checkbox" class="form-check-input" id="customCheck6">
                                        <label class="form-check-label" for="customCheck6">&nbsp;</label>
                                    </div>
                                </td>
                                <td>
                                    <img src="assets/images/products/product-5.jpg" alt="contact-img" title="contact-img" class="rounded me-3" height="48" />
                                    <p class="m-0 d-inline-block align-middle font-16">
                                        <a href="" class="text-body">Cardan Armchair</a>
                                        <br/>
                                        <span class="text-warning mdi mdi-star"></span>
                                        <span class="text-warning mdi mdi-star"></span>
                                        <span class="text-warning mdi mdi-star"></span>
                                        <span class="text-warning mdi mdi-star"></span>
                                        <span class="text-warning mdi mdi-star"></span>
                                    </p>
                                </td>
                                <td>
                                    Plastic Armchair
                                </td>
                                <td>
                                    08/02/2018
                                </td>
                                <td>
                                    $59.69
                                </td>

                                <td>
                                    26
                                </td>
                                <td>
                                    <span class="badge bg-success">Active</span>
                                </td>

                                <td class="table-action">
                                    <a href="" class="action-icon"> <i class="mdi mdi-eye"></i></a>
                                    <a href="" class="action-icon"> <i class="mdi mdi-square-edit-outline"></i></a>
                                    <a href="" class="action-icon"> <i class="mdi mdi-delete"></i></a>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <div class="form-check">
                                        <input type="checkbox" class="form-check-input" id="customCheck7">
                                        <label class="form-check-label" for="customCheck7">&nbsp;</label>
                                    </div>
                                </td>
                                <td>
                                    <img src="assets/images/products/product-3.jpg" alt="contact-img" title="contact-img" class="rounded me-3" height="48" />
                                    <p class="m-0 d-inline-block align-middle font-16">
                                        <a href="" class="text-body">Bootecos Plastic Armchair</a>
                                        <br/>
                                        <span class="text-warning mdi mdi-star"></span>
                                        <span class="text-warning mdi mdi-star"></span>
                                        <span class="text-warning mdi mdi-star"></span>
                                        <span class="text-warning mdi mdi-star"></span>
                                        <span class="text-warning mdi mdi-star-half"></span>
                                    </p>
                                </td>
                                <td>
                                    Wing Chairs
                                </td>
                                <td>
                                    07/15/2018
                                </td>
                                <td>
                                    $148.66
                                </td>

                                <td>
                                    485
                                </td>
                                <td>
                                    <span class="badge bg-danger">Deactive</span>
                                </td>

                                <td class="table-action">
                                    <a href="" class="action-icon"> <i class="mdi mdi-eye"></i></a>
                                    <a href="" class="action-icon"> <i class="mdi mdi-square-edit-outline"></i></a>
                                    <a href="" class="action-icon"> <i class="mdi mdi-delete"></i></a>
                                </td>
                            </tr>

                            <tr>
                                <td>
                                    <div class="form-check">
                                        <input type="checkbox" class="form-check-input" id="customCheck8">
                                        <label class="form-check-label" for="customCheck8">&nbsp;</label>
                                    </div>
                                </td>
                                <td>
                                    <img src="assets/images/products/product-6.jpg" alt="contact-img" title="contact-img" class="rounded me-3" height="48" />
                                    <p class="m-0 d-inline-block align-middle font-16">
                                        <a href="" class="text-body">Adirondack Chair</a>
                                        <br/>
                                        <span class="text-warning mdi mdi-star"></span>
                                        <span class="text-warning mdi mdi-star"></span>
                                        <span class="text-warning mdi mdi-star"></span>
                                        <span class="text-warning mdi mdi-star"></span>
                                        <span class="text-warning mdi mdi-star"></span>
                                    </p>
                                </td>
                                <td>
                                    Aeron Chairs
                                </td>
                                <td>
                                    07/07/2018
                                </td>
                                <td>
                                    $65.94
                                </td>

                                <td>
                                    652
                                </td>
                                <td>
                                    <span class="badge bg-success">Active</span>
                                </td>

                                <td class="table-action">
                                    <a href="" class="action-icon"> <i class="mdi mdi-eye"></i></a>
                                    <a href="" class="action-icon"> <i class="mdi mdi-square-edit-outline"></i></a>
                                    <a href="" class="action-icon"> <i class="mdi mdi-delete"></i></a>
                                </td>
                            </tr>
                            
                            <tr>
                                <td>
                                    <div class="form-check">
                                        <input type="checkbox" class="form-check-input" id="customCheck9">
                                        <label class="form-check-label" for="customCheck9">&nbsp;</label>
                                    </div>
                                </td>
                                <td>
                                    <img src="assets/images/products/product-2.jpg" alt="contact-img" title="contact-img" class="rounded me-3" height="48" />
                                    <p class="m-0 d-inline-block align-middle font-16">
                                        <a href="" class="text-body">Bean Bag Chair</a>
                                        <br/>
                                        <span class="text-warning mdi mdi-star"></span>
                                        <span class="text-warning mdi mdi-star"></span>
                                        <span class="text-warning mdi mdi-star"></span>
                                        <span class="text-warning mdi mdi-star"></span>
                                        <span class="text-warning mdi mdi-star"></span>
                                    </p>
                                </td>
                                <td>
                                    Wooden Chairs
                                </td>
                                <td>
                                    06/30/2018
                                </td>
                                <td>
                                    $99
                                </td>

                                <td>
                                    1,021
                                </td>
                                <td>
                                    <span class="badge bg-danger">Deactive</span>
                                </td>
                                <td class="table-action">
                                    <a href="" class="action-icon"> <i class="mdi mdi-eye"></i></a>
                                    <a href="" class="action-icon"> <i class="mdi mdi-square-edit-outline"></i></a>
                                    <a href="" class="action-icon"> <i class="mdi mdi-delete"></i></a>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <div class="form-check">
                                        <input type="checkbox" class="form-check-input" id="customCheck10">
                                        <label class="form-check-label" for="customCheck10">&nbsp;</label>
                                    </div>
                                </td>
                                <td>
                                    <img src="assets/images/products/product-3.jpg" alt="contact-img" title="contact-img" class="rounded me-3" height="48" />
                                    <p class="m-0 d-inline-block align-middle font-16">
                                        <a href="" class="text-body">The butterfly chair</a>
                                        <br/>
                                        <span class="text-warning mdi mdi-star"></span>
                                        <span class="text-warning mdi mdi-star"></span>
                                        <span class="text-warning mdi mdi-star"></span>
                                        <span class="text-warning mdi mdi-star"></span>
                                        <span class="text-warning mdi mdi-star-half"></span>
                                    </p>
                                </td>
                                <td>
                                    Dining Chairs
                                </td>
                                <td>
                                    06/19/2018
                                </td>
                                <td>
                                    $58
                                </td>

                                <td>
                                    874
                                </td>
                                <td>
                                    <span class="badge bg-success">Active</span>
                                </td>

                                <td class="table-action">
                                    <a href="" class="action-icon"> <i class="mdi mdi-eye"></i></a>
                                    <a href="" class="action-icon"> <i class="mdi mdi-square-edit-outline"></i></a>
                                    <a href="" class="action-icon"> <i class="mdi mdi-delete"></i></a>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <div class="form-check">
                                        <input type="checkbox" class="form-check-input" id="customCheck11">
                                        <label class="form-check-label" for="customCheck11">&nbsp;</label>
                                    </div>
                                </td>
                                <td>
                                    <img src="assets/images/products/product-4.jpg" alt="contact-img" title="contact-img" class="rounded me-3" height="48" />
                                    <p class="m-0 d-inline-block align-middle font-16">
                                        <a href="" class="text-body">Eames Lounge Chair</a>
                                        <br/>
                                        <span class="text-warning mdi mdi-star"></span>
                                        <span class="text-warning mdi mdi-star"></span>
                                        <span class="text-warning mdi mdi-star"></span>
                                        <span class="text-warning mdi mdi-star"></span>
                                        <span class="text-warning mdi mdi-star-half"></span>
                                    </p>
                                </td>
                                <td>
                                    Baby Chairs
                                </td>
                                <td>
                                    05/06/2018
                                </td>
                                <td>
                                    $39.5
                                </td>

                                <td>
                                    1,254
                                </td>
                                <td>
                                    <span class="badge bg-success">Active</span>
                                </td>

                                <td class="table-action">
                                    <a href="" class="action-icon"> <i class="mdi mdi-eye"></i></a>
                                    <a href="" class="action-icon"> <i class="mdi mdi-square-edit-outline"></i></a>
                                    <a href="" class="action-icon"> <i class="mdi mdi-delete"></i></a>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <div class="form-check">
                                        <input type="checkbox" class="form-check-input" id="customCheck12">
                                        <label class="form-check-label" for="customCheck12">&nbsp;</label>
                                    </div>
                                </td>
                                <td>
                                    <img src="assets/images/products/product-5.jpg" alt="contact-img" title="contact-img" class="rounded me-3" height="48" />
                                    <p class="m-0 d-inline-block align-middle font-16">
                                        <a href="" class="text-body">Farthingale Chair</a>
                                        <br/>
                                        <span class="text-warning mdi mdi-star"></span>
                                        <span class="text-warning mdi mdi-star"></span>
                                        <span class="text-warning mdi mdi-star"></span>
                                        <span class="text-warning mdi mdi-star"></span>
                                        <span class="text-warning mdi mdi-star-half"></span>
                                    </p>
                                </td>
                                <td>
                                    Plastic Armchair
                                </td>
                                <td>
                                    04/09/2018
                                </td>
                                <td>
                                    $78.66
                                </td>

                                <td>
                                    524
                                </td>
                                <td>
                                    <span class="badge bg-danger">Deactive</span>
                                </td>

                                <td class="table-action">
                                    <a href="" class="action-icon"> <i class="mdi mdi-eye"></i></a>
                                    <a href="" class="action-icon"> <i class="mdi mdi-square-edit-outline"></i></a>
                                    <a href="" class="action-icon"> <i class="mdi mdi-delete"></i></a>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <div class="form-check">
                                        <input type="checkbox" class="form-check-input" id="customCheck13">
                                        <label class="form-check-label" for="customCheck13">&nbsp;</label>
                                    </div>
                                </td>
                                <td>
                                    <img src="assets/images/products/product-6.jpg" alt="contact-img" title="contact-img" class="rounded me-3" height="48" />
                                    <p class="m-0 d-inline-block align-middle font-16">
                                        <a href="" class="text-body">Unpowered aircraft</a>
                                        <br/>
                                        <span class="text-warning mdi mdi-star"></span>
                                        <span class="text-warning mdi mdi-star"></span>
                                        <span class="text-warning mdi mdi-star"></span>
                                        <span class="text-warning mdi mdi-star"></span>
                                        <span class="text-warning mdi mdi-star-half"></span>
                                    </p>
                                </td>
                                <td>
                                    Wing Chairs
                                </td>
                                <td>
                                    03/24/2018
                                </td>
                                <td>
                                    $49
                                </td>

                                <td>
                                    204
                                </td>
                                <td>
                                    <span class="badge bg-danger">Deactive</span>
                                </td>

                                <td class="table-action">
                                    <a href="" class="action-icon"> <i class="mdi mdi-eye"></i></a>
                                    <a href="" class="action-icon"> <i class="mdi mdi-square-edit-outline"></i></a>
                                    <a href="" class="action-icon"> <i class="mdi mdi-delete"></i></a>
                                </td>
                            </tr>
                        </tbody>
                    </table>
                </div>
            </div> <!-- end card-body-->
        </div> <!-- end card-->
    </div> <!-- end col -->
</div>
<!-- #include file="./layout/footer.asp" -->
</body>
</html>