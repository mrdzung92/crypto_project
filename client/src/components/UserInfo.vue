<template>
    <van-popup v-model:show="showInfo" position="left" class="user-info" :style="{ width: '100%', height: '100%' }"
        closeable @click-overlay="onClickOverlay" @click-close-icon="onClickCloseIcon">

        <div class="user-info-content">
            <div class="user">
                <img class="user-img" src="@/assets/img/common/userImg.svg" alt="">
                <div class="right">
                    <p class="uid"><span>UID: {{ userInfo.id }}</span><img src="@/assets/img/common/copy.svg" alt=""></p>
                    <p>信用分: 0</p>
                </div>
            </div>
            <ul class="menu-list">
                <li v-for="item in menuList" :key="item.title">
                    <router-link class="link" :to="item.path">
                        <p class="left">
                            <img :src="item.icon" alt="">
                            <span>{{ item.title }}</span>
                        </p>
                        <p class="right">
                            <span class="desc">{{ item.desc }}</span>
                            <van-icon name="arrow" />
                        </p>

                    </router-link>
                </li>
            </ul>
            <div class="logout" @click="logout">
                <img src="@/assets/img/userinfo/tuichu.svg" alt="">
                <p>退出登录</p>
            </div>
        </div>

    </van-popup>
</template>

<script>
import icon1 from '@/assets/img/userinfo/primary.png'
import icon2 from '@/assets/img/userinfo/advanced.png'
import icon3 from '@/assets/img/userinfo/tardPwd.png'
import icon4 from '@/assets/img/userinfo/loginPwd.png'
import icon5 from '@/assets/img/userinfo/certified.png'
import icon6 from '@/assets/img/userinfo/termsService.png'
import icon7 from '@/assets/img/userinfo/paper.png'
import icon8 from '@/assets/img/userinfo/language.png'
import { showConfirmDialog } from 'vant';


export default {
    props: {
        show: Boolean,
        default: false,
    },
    data() {
        return {
            userInfo: {},
            showInfo: this.$props.show,
            menuList: [
                {
                    icon: icon1,
                    path: '#',
                    title: '初级认证',
                    desc: '已认证',
                },
                {
                    path: '#',
                    icon: icon2,
                    title: '实名认证',
                },
                {
                    path: '#',
                    icon: icon3,
                    title: '设置资金密码',
                },
                {
                    path: '#',
                    icon: icon4,
                    title: '设置登录密码',
                },
                {
                    path: '#',
                    icon: icon5,
                    title: '邮箱认证',
                },
                {
                    path: '#',
                    icon: icon6,
                    title: '服务条款',
                },
                {
                    path: '#',
                    icon: icon7,
                    title: '白皮书',
                },
                {
                    path: '#',
                    icon: icon8,
                    title: '简体中文',
                },
            ]
        };
    },
    created() {
        this.userInfo = JSON.parse(localStorage.getItem('userInfo'));

    },
    methods: {
        onClickOverlay() {
            this.showInfo = false;
        },
        onClickCloseIcon() {
            this.showInfo = false;
        },
        logout() {
            showConfirmDialog({
                title: '温馨提示',
                message:
                    '您确定要退出登录吗？',
            })
                .then(() => {
                    localStorage.removeItem('token');
                    localStorage.removeItem('isLogin');
                    this.showInfo=false;
                    this.$store.commit('logout');
                })
                .catch(() => {
                    // on cancel
                });
        }
    },
    watch: {
        show(newVal) {
            this.showInfo = newVal; // Cập nhật showInfo khi show thay đổi
        },
        showInfo(newVal) {
            this.$emit('update:show', newVal); // Gửi sự thay đổi ngược lại cho component cha
        },
    }
}
</script>

<style lang="scss" scoped>
.user-info {
    .user-info-content {
        padding-top: 4rem;

        .user {
            display: flex;
            padding: 2rem 1.5rem;

            .user-img {
                width: 5rem;
                height: 5rem;
                margin-right: 1rem;
            }

            .right {
                p {
                    &:first-child {
                        span {
                            font-weight: bold;
                            font-size: 1.6rem;
                            padding-right: 1rem;
                        }


                    }
                }
            }
        }

        .menu-list {
            padding: 1.5rem;
            border-bottom: .1rem solid var(--color-border2);

            li {

                .link {
                    padding: 1rem 0;
                    display: flex;
                    justify-content: space-between;
                    align-items: center;

                    .left {
                        display: flex;
                        align-items: center;

                        img {
                            width: 2rem;
                            height: 2rem;
                            margin-right: 1rem;
                        }
                    }

                    .right {
                        .desc {
                            color: var(--color-icon);
                        }
                    }
                }
            }
        }

        .logout {
            display: flex;
            padding: 1.5rem;
            color: var(--color-icon);

            img {
                width: 2rem;
                margin-right: 1rem;
            }
        }
    }
}
</style>