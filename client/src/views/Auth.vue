<template>
    <div class="auth-page">
        <div class="head-title">
            <router-link to="/">
                <van-icon name="arrow-left" />
                Back to Home
            </router-link>
        </div>
        <div class="logo"><img src="@/assets/img/tmp/logo.png" alt=""></div>
        <div class="head-action">
            <p @click="changeTab(true)" :class="{ active: isLogin }">Login</p>
            <p @click="changeTab(false)" :class="{ active: !isLogin }">Register</p>
            <span ref="tabIndicator"></span>
        </div>
        <div class="wrapper-form">

            <form ref="AuthForm" v-if="isLogin" action="" class="login">
                <div class="form-group">
                    <input name="username" v-model="input.username" type="text" required="required"
                        @focus="removeError">
                    <van-icon class="icon2" name="contact" />
                    <label for="username">Account</label>
                    <span class="message"></span>
                </div>
                <div class="form-group">
                    <input name="password" :type="typePassword ? 'password' : 'text'" v-model="input.password"
                        @focus="removeError" required="required">
                    <van-icon class="icon2" name="lock" />
                    <van-icon class="icon" :name="!displayPassword ? 'closed-eye' : 'eye-o'"
                        @mousedown="handleDisplayPassword(1)" />
                    <label for="password">Password</label>
                    <span class="message"></span>
                </div>
                <div class="form-group">
                    <input name="verify_code" v-model="input.verify_code" type="text" required="required"
                        @focus="removeError">
                    <van-icon class="icon2" name="warning" />
                    <img :src="captcha_src" alt="captcha" @click="getVerifyCode">
                    <label>Verify Code</label>
                    <span class="message"></span>
                </div>
                <div class="footer">
                    <div class="left">
                        <input type="checkbox">
                        <label>Remember me</label>
                    </div>
                    <div class="right">
                        <router-link to="#">Forget Password</router-link>
                    </div>
                </div>

            </form>
            <form v-else ref="AuthForm" action="" class="register">
                <div class="form-group">
                    <input name="username" type="text" required="required" v-model="input.username"
                        @focus="removeError">
                    <van-icon class="icon2" name="contact" />
                    <label for="username">Account</label>
                    <span class="message"></span>
                </div>
                <div class="form-group">
                    <input name="password" :type="typePassword ? 'password' : 'text'" required="required"
                        v-model="input.password" @focus="removeError">
                    <van-icon class="icon2" name="lock" />
                    <van-icon class="icon" :name="!displayPassword ? 'closed-eye' : 'eye-o'"
                        @mousedown="handleDisplayPassword(1)" />
                    <label for="password">Password</label>
                    <span class="message"></span>
                </div>
                <div class="form-group">
                    <input name="password_confirm" :type="typeConfirmPassword ? 'password' : 'text'"
                        v-model="input.password_confirm" required="required" @focus="removeError">
                    <van-icon class="icon2" name="lock" />
                    <van-icon class="icon" :name="!displayConfirmPassword ? 'closed-eye' : 'eye-o'"
                        @mousedown="handleDisplayPassword(2)" />

                    <label for="password_confirm">Confirm Password</label>
                    <span class="message"></span>
                </div>
                <div class="form-group">
                    <input name="invite_code" v-model="input.invite_code" type="text" required="required"
                        autocomplete="off">
                    <van-icon class="icon2" name="friends" />
                    <label>Invite Code</label>
                    <span class="message"></span>
                </div>
                <div class="form-group">
                    <input name="verify_code" v-model="input.verify_code" type="text" required="required"
                        autocomplete="off" @focus="removeError">
                    <van-icon class="icon2" name="warning" />
                    <img :src="captcha_src" alt="captcha" @click="getVerifyCode">
                    <label>Verify Code</label>
                    <span class="message"></span>
                </div>
            </form>
            <ul class="action">
                <li @click="auth">{{ btnAuth }}</li>
                <!-- <li> <span class="text">Or</span></li> -->
                <!-- <li>
                    <p><img src="@/assets/img/auth/google.png" alt=""><span>Continute with Google</span></p>
                </li>
                <li>
                    <p><img src="@/assets/img/auth/facebook.png" alt=""><span>Continute with FaceBook</span></p>
                </li> -->
            </ul>
        </div>
    </div>
</template>

<script>

import { showLoadingToast, closeToast,showFailToast,showSuccessToast,showToast  } from 'vant';
export default {
    components: {
        // Back
    },
    data() {
        return {
            captcha_src: '',
            uniqid: '',
            input: {
                username: '',
                password: '',
                password_confirm: '',
                invite_code: '',
                verify_code: ''
            },
            loading: false,
            isLogin: true,
            typePassword: true,
            typeConfirmPassword: true,
            displayPassword: false,
            displayConfirmPassword: false,
            btnAuth: 'Login'
        }
    },
    created() {
        const userInfo = JSON.parse(localStorage.getItem('userInfo'));
        if (userInfo) {
           this.input.username = userInfo.username;
        }
        this.getVerifyCode()

    },
    mounted() {
        this.checkLogin()
    },

    methods: {
        checkLogin() {
            const isLogin = JSON.parse(localStorage.getItem('isLogin'));
            if (isLogin) {
                this.$router.push({ name: 'Home' })
            } else {
                const task = this.$route.params.task;
                let params = 'login'
                if (task == 'register') {
                    params = 'register'
                    if(this.$route.params.invite !==''){
                        this.input.invite_code = this.$route.params.invite
                    }
                    this.changeTab(false)
                }
                this.$router.replace({ name: 'Auth', params: { task: params, invite :this.input.invite_code } });
            }
        },
        auth() {
            if(this.loading) return;
            let validate = true;
            if (this.isLogin) {
                validate = this.validate()
            } else {
                validate = this.validate('register')
            }
            if (!validate) {
                this.getVerifyCode()
                return;
            }
            const params = {
                verify_code: this.input.verify_code,
                uniqid: this.uniqid,
                username: this.input.username,
                password: this.input.password,
                login_type: true
            }
            if (!this.isLogin) {
                params.password_confirm = this.input.password_confirm;
                params.invite_code = this.input.invite_code;
                params.login_type = false;
            }

            showLoadingToast({
                loadingType: 'spinner',
                message: '加载中...',
            })
            this.loading = true;
            this.$wedApi.post('Guest/auth', params).then(res => {
                this.loading = false;
                closeToast();
                const data = res.data;
                if (data.code === 1) {
                    showSuccessToast( this.$route.params.task === 'login'?'登录成功':'注册成功');
                    localStorage.setItem('isLogin', true);
                    localStorage.setItem('token', data.data.token);
                    this.$socket.emit('updateUserInfo', data.data);
                    delete  data.data.token;
                    localStorage.setItem('userInfo', JSON.stringify(data.data));
                    setTimeout(() => {
                        showToast('登录成功')
                        this.$router.push({ name: 'Home' })
                    }, 1000)

                } else {
                    showFailToast(data.info);      
                    this.getVerifyCode()
                }

            })
        },
        validate(type = 'login') {
            const form = this.$refs.AuthForm;
            let validate = true;
            const inputVal = {
                username: this.input.username,
                password: this.input.password,
                verify_code: this.input.verify_code

            };
            if (type == 'register') {
                inputVal.password_confirm = this.input.password_confirm;
            }

            for (let key in inputVal) {
                if (inputVal.hasOwnProperty(key) && inputVal[key] == '') {
                    const input = form.querySelector(`input[name="${key}"]`);
                    input.parentElement.classList.add('error');
                    const label = input.parentElement.querySelector('label').innerText;
                    input.parentElement.querySelector('.message').innerText = label + ' is required';
                    validate = false;
                }
            }

            if (!validate) return false;
            return true;
        },
        removeError(e) {
            e.target.parentElement.classList.remove('error');
            e.target.parentElement.querySelector('.message').innerText = '';
        },
        getVerifyCode() {
            this.$wedApi.get('Guest/getVerifyCode').then(res => {
                this.captcha_src = res.data.data.captcha_src;
                this.uniqid = res.data.data.uniqid;
            })
        },

        changeTab(isLogin) {
            this.isLogin = isLogin;
            const tabIndicator = this.$refs.tabIndicator;
            let params = 'login'
            this.btnAuth = 'Login'
            if (!isLogin) {
                params = 'register';
                this.btnAuth = 'Register'
                tabIndicator.style.left = '50%';
            } else {
                tabIndicator.style.left = '0';
            }
            this.$router.replace({ name: 'Auth', params: { task: params } });
        },
        handleDisplayPassword(type) {
            if (type == 1) {
                this.typePassword = !this.typePassword;
                this.displayPassword = !this.displayPassword;
            } else {
                this.typeConfirmPassword = !this.typeConfirmPassword;
                this.displayConfirmPassword = !this.displayConfirmPassword;
            }
        }
    }
}

</script>

<style lang="scss" scoped>
.auth-page {
    padding: 0 .8rem;
    padding-bottom: 20rem;

    .head-title {
        font-size: 1.8rem;
        font-weight: 500;
        padding: .8rem 0;

    }

    .logo {
        margin: 2rem auto;

        img {
            display: block;
            margin: 0 auto;
            width: 200px;
        }
    }

    .head-action {
        display: flex;
        justify-content: space-between;
        align-items: center;
        border-top: .1rem solid #ccc;
        border-left: .1rem solid #ccc;
        border-right: .1rem solid #ccc;
        position: relative;
        overflow: hidden;
        border-top-left-radius: .8rem;
        border-top-right-radius: .8rem;

        p {
            flex: 1;
            text-align: center;
            font-weight: bold;
            font-size: 1.8rem;
            position: relative;
            z-index: 1;
            color: #ccc;
            transition: 0.5s;

            &.active {
                color: white;
            }
        }

        span {
            display: block;
            position: absolute;
            background-color: var(--color-icon);
            width: 50%;
            height: 100%;
            left: 0%;
            bottom: 0;
            transition: 0.5s;

            &::before {
                position: absolute;
                content: '';
                display: block;
                border: 2.8rem solid transparent;
                left: -2.8rem;
                bottom: 0;
                border-bottom-color: var(--color-icon);
            }

            &::after {
                position: absolute;
                content: '';
                display: block;
                border: 2.8rem solid transparent;
                right: -2.8rem;
                // transform: translateX(-50%);
                bottom: 0;
                border-bottom-color: var(--color-icon);
            }
        }
    }

    .wrapper-form {
        text-align: center;
        padding: 2rem;
        border: .1rem solid #ccc;
        border-bottom-left-radius: .8rem;
        border-bottom-right-radius: .8rem;

        form {
            display: flex;
            flex-direction: column;
            align-items: center;
            justify-content: center;
            gap: 2.8rem;

            .form-group {
                position: relative;
                width: 100%;

                &.error {
                    input {
                        border-color: red;
                    }

                    label,
                    .message {
                        color: red;
                    }

                }

                input {
                    width: 100%;
                    padding: 1.2rem 4rem 1.2rem 4.8rem;
                    border: none;
                    border: .1rem solid transparent;
                    border-color: var(--color-border);
                    border-radius: .4rem;
                    outline: none;
                    background-color: transparent;

                    &:focus,
                    &:valid {
                        border-color: var(--color-icon);
                    }

                    &:focus~label,
                    &:valid~label {
                        background-color: var(--color-bg2);
                        border-color: var(--color-icon);
                        transform: translateX(.7rem) translateY(-1rem);
                        padding: 0 .8rem;
                        border-radius: .4rem;
                        line-height: 1.6rem;
                        color: var(--color-icon);
                    }

                    &:focus~.icon2,
                    &:valid~.icon2 {
                        color: var(--color-icon);
                    }


                }

                label {
                    position: absolute;
                    left: 0;
                    padding: .8rem 1rem .8rem 4.8rem;
                    color: var(--color-text-disabled);
                    pointer-events: none;
                    transition: 0.5s;
                    border: .1rem solid transparent;
                }

                .icon {
                    position: absolute;
                    right: 1rem;
                    top: 50%;
                    transform: translateY(-50%);
                    color: var(--color-text-disabled);
                }

                .icon2 {
                    position: absolute;
                    left: 1rem;
                    top: 50%;
                    transform: translateY(-50%);
                    color: #ccc;
                }

                img {

                    position: absolute;
                    display: block;
                    top: .1rem;
                    right: .2rem;
                    width: 10rem;
                    height: calc(100% - .2rem);
                }

                .message {
                    position: absolute;
                    left: 0;
                    bottom: -2rem;
                }


            }
        }

        .footer {
            display: flex;
            justify-content: space-between;
            width: 100%;

            .left {
                display: flex;
                align-items: center;

                input {
                    margin-right: .4rem;
                    width: 1.6rem;
                    height: 1.6rem;
                }
            }

            .right {
                a {
                    color: var(--color-icon);
                }
            }
        }

        .action {
            margin-top: 2rem;

            li {
                border: .1rem solid transparent;
                border-color: var(--color-border);
                margin-bottom: .8rem;
                border-radius: .4rem;
                line-height: 3.6rem;
                text-align: center;

                display: flex;
                align-items: center;
                justify-content: center;

                p {
                    display: inline-flex;
                    align-items: center;
                    width: 80%;

                    // span {
                    //   flex: 1;
                    //   text-align: center;
                    // }
                }

                img {
                    width: 2rem;
                    height: 2rem;
                    margin-right: .1rem;
                }

                &:first-child {
                    background-color: var(--color-icon);
                    border-color: var(--color-icon);
                    font-weight: bold;
                    color: white;
                }

                &:nth-child(2) {
                    border-color: transparent;
                    line-height: 1.6rem;
                    position: relative;


                    span.text {
                        z-index: 1;
                        background-color: var(--color-background);
                        padding: 0 .8rem;

                    }

                    &::before {
                        content: '';
                        position: absolute;
                        width: 100%;
                        height: .1rem;
                        background-color: var(--color-border);
                        left: 0;
                        top: 50%;
                        transform: translateY(-50%);
                        // z-index: -1;
                    }


                }



            }
        }
    }
}
</style>