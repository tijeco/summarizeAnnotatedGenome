SAMPLES, = glob_wildcards("{samples}.fa")

rule final:
    input:
        expand("{samples}.pep", samples = SAMPLES)

rule gff3_to_gtf:
    input:
        "{samples}.gff3"
    output:
        "{samples}.gtf"
    shell:
        "agat_convert_sp_gff2gtf.pl --gff {input} -o {output}"

rule gtf_to_cds:
    input:
        gtf = "{samples}.gtf",
        fasta = "{samples}.fa"
    output:
        "{samples}.cds"
    shell:
        "seqkit subseq --feature CDS --gtf {input.gtf} {input.fasta} > {output}"

rule cds_to_pep:
    input:
        "{sample}.cds"
    output:
        "{sample}.pep"
    shell:
        "seqkit translate {input} > {output}"

