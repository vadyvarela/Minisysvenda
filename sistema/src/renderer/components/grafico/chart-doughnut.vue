<template>
    <chartjs-doughnut v-bind:labels="labels"
    v-bind:datasets="datasets"
    v-bind:option="option"
    v-bind:bind="true"/>
</template>

<script>
import listaVendaServices from "@/services/listaVendaServices";
export default {
    data() {
    return {
        labels: ["Foo", "Bar", "Baz"],
        datasets: [
            {
            data: [10, 20, 40],
            backgroundColor: ["#b388ff", "#82b1ff", "#80d8ff"],
            hoverBackgroundColor: ["#673ab7", "#2196f3", "#03a9f4"]
            }
        ],
        option: {}
        };
    },
    async mounted() {
        this.ProdMaisVendido = (await listaVendaServices.pmaisvendido()).data;
        console.log("ProdMaisVendido: ", this.ProdMaisVendido)
    }
};
</script>