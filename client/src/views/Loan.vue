<template>
    <div class="loan-page">
        <van-nav-bar class="header" :title="headerTitle" left-text="返回" left-arrow @click-left="$router.go(-1)">
            <template #right>
                <img @click.stop="goPath('/LoanRule')" src="@/assets/img/common/guize.svg" alt=""
                    style="width: 2.4rem; height: 2.4rem;">
                <img @click.stop="goPath('/LoanRecord')" src="@/assets/img/common/jilu.svg" alt=""
                    style="width: 2.4rem; height: 2.4rem; margin-left: 1rem;">
            </template>
        </van-nav-bar>
        <div class="loan-content">
            <form action="">
                <p class="tit">经平台审核，您可向平台申请一笔借款！</p>
                <div class="form-group">
                    <label for="">借贷产品</label>
                    <p class="value">
                        <van-dropdown-menu class="dropdown">
                            <van-dropdown-item v-model="loanOpt" :options="optionsLoan" />
                        </van-dropdown-menu>
                    </p>

                </div>
                <div class="form-group">
                    <label for="">借款金额<span>(USDT)</span></label>
                    <input type="text" class="value" placeholder="输入借款金额">
                </div>
                <div class="form-group">
                    <label for="">还款日期</label>
                    <p class="value">{{ optionsLoan[loanOpt].repayment }}</p>
                </div>
            </form>
            <ul class="loan-detai">
                <li>
                    <span class="title">日利率</span>
                    <span class="value">0.133%</span>
                </li>
                <li>
                    <span class="title">利息</span>
                    <span class="value">0 USDT</span>
                </li>
                <li>
                    <span class="title">还款方式</span>
                    <span class="value">到期一次还本息</span>
                </li>
                <li>
                    <span class="title">放款机构</span>
                    <span class="value">Binance</span>
                </li>
            </ul>

            <div class="upload">
                <p class="upload-title">证件照<span>(请确保证件照清晰可见)</span></p>
                <div class="upload-box">
                    <div class="upload-item">
                        <van-uploader class="loan-upload" :after-read="afterRead" upload-text="上传正面" image-fit="cover"
                            v-model="fileList[0]" reupload max-count="1"
                            upload-icon="/src/assets/img/upload/upload.png">
                        </van-uploader>
                    </div>
                    <div class="upload-item">
                        <van-uploader class="loan-upload" :after-read="afterRead" upload-text="上传返面"
                            v-model="fileList[1]" reupload max-count="1"
                            upload-icon="/src/assets/img/upload/upload.png">
                        </van-uploader>
                    </div>
                    <div class="upload-item">
                        <van-uploader class="loan-upload" :after-read="afterRead" upload-text="上传手持证件照"
                            v-model="fileList[2]" reupload max-count="1"
                            upload-icon="/src/assets/img/upload/upload.png">
                        </van-uploader>
                    </div>
                </div>
                <div class="upload-btn">
                    确认上传
                </div>
            </div>
        </div>
    </div>

</template>

<script>
export default {
    data() {
        return {
            headerTitle: '助力贷',
            optionsLoan: [
                { text: '1000~10000 USDT', value: 0, repayment: 7 },
                { text: '1000~1000000 USDT', value: 1, repayment: 15 },
                { text: '1000~2000000 USDT', value: 2, repayment: 30 },
            ],
            loanOpt: 0,
            fileList: []
        }
    },
    methods: {
        afterRead(file) {
            console.log(file)
        },

        goPath(path) {
            this.$router.push(path)
        }
    }
}
</script>

<style lang="scss" scoped>
.loan-page {
    padding-bottom: 5rem;
    .header {
        position: fixed;
        max-width: 540px;
        width: 100%;
    }

    .loan-content {
        padding-top: 5.6rem;

        form {
            padding: 0 1.5rem;
            border-bottom: 1px solid var(--color-border2);

            .tit {
                margin-bottom: 3rem;
                font-size: 1.2rem;
                color: var(--color-sell);
            }

            .form-group {
                margin-bottom: 1.5rem;

                label {
                    margin-bottom: 1rem;
                    display: block;
                }

                input {
                    width: 100%;
                    outline: none;
                    border: none;
                }

                .value {
                    // height: 4.6rem;
                    background: #f3f1f7;
                    padding: 0 1.5rem;
                    line-height: 4.6rem;

                    .dropdown {
                        .van-dropdown-menu__bar {
                            background: transparent;
                        }
                    }
                }

            }

        }

        .loan-detai {
            padding: 0 1.5rem;
            border-bottom: 1px solid var(--color-border2);

            li {
                margin: 3rem 0;
                display: flex;
                justify-content: space-between;

                .title {
                    color: var(--color-text3);
                }
            }
        }

        .upload {
            padding: 0 1.5rem;

            .upload-title {
                margin: 2rem 0 1rem 0rem;

                span {
                    color: var(--color-text3);
                }
            }

            .upload-box {
                .upload-item {
                    border: 1px solid var(--color-border2);
                    margin-bottom: 1rem;
                    height: 15rem;
                    display: flex;
                    align-items: center;
                    justify-content: center;
                }

            }

            .upload-btn {
                background: var(--color-icon);
                color: var(--color-text4);
                text-align: center;
                line-height: 4.2rem;
                border-radius: .4rem;
                margin-top: 5rem;
                // margin: 5rem 0;
            }


        }

    }
}
</style>